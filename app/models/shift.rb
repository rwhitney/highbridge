require "shift_members_validator"

class Shift < ActiveRecord::Base
  belongs_to :e1, :class_name => 'Member', :foreign_key => "e1member_id"
  belongs_to :e2, :class_name => 'Member', :foreign_key => "e2member_id"
  belongs_to :driver, :class_name => 'Member', :foreign_key => "dmember_id"
  
  validates_presence_of :shiftdate, :shiftnum
  validates_numericality_of :shiftnum
  validates_inclusion_of :shiftnum, :in => 1..4
  validates_with ShiftMembersValidator #verifies shift has at least one member
  
  def self.find_all_in_month(thedate)
    firstdate = Date.new(thedate.year, thedate.month, 1)
    lastdate = Date.new(thedate.year, thedate.month, Time.days_in_month(thedate.month, thedate.year))
    self.find_all_between_days(firstdate, lastdate)
  end
  
  def self.find_all_between_days(firstdate, lastdate)
    find(:all, :conditions => ["shiftdate >= ? and shiftdate <= ?", firstdate.to_date, lastdate.to_date], :order => 'shiftdate ASC, shiftnum ASC', :readonly => true)
  end
  
  def self.find_all_in_day(thedate)
    find(:all, :conditions => ["shiftdate = ?", thedate.to_date], :order => 'shiftnum ASC', :readonly => true)
  end
  
  def self.find_by_date_and_num(thedate, shiftnum)
    find(:first, :conditions => ["shiftdate = ? and shiftnum = ?", thedate.to_date, shiftnum])
  end
  
  def assign_member(position, member)
    position = position.downcase
    if position == 'e1'
      self.e1 = member
    elsif position == 'e2'
      self.e2 = member
    elsif position == 'd' || position == 'driver'
      self.driver = member
    end
  end
  
  def Shift.calc_monthly_total(shifts, month, member)
    ttl_hours = 0
    for shift in shifts do
      ttl_hours += 6 if shift.shiftdate.month == month && shift.has_member?(member)
    end
    return ttl_hours
  end
  
  def has_member?(member)
    self.e1 == member || self.e2 == member || self.driver == member
  end
  
  def status
    if isfull?
      return "full"
    elsif hastwo?
      return "hastwo"
    elsif hasone?
      return "hasone"
    else
      return "empty"
    end
  end
  
  def member_count
    ct = 0
    ct = ct + 1 unless e1member_id == nil
    ct = ct + 1 unless e2member_id == nil
    ct = ct + 1 unless dmember_id == nil
    return ct
  end
  
  def isfull?
    e1member_id && e2member_id && dmember_id
  end
  
  def hastwo?
    member_count == 2
  end
  
  def hasone?
    member_count == 1
  end
  
  def user_is_signedup?(user)
    e1 == user || e2 == user || driver == user
  end
  
  def user_is_signedup_as(user)
    return "EMT 1" if e1 == user
    return "EMT 2" if e2 == user
    return "driver" if driver == user
  end
end
