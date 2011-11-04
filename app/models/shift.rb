require "shift_members_validator"

class Shift < ActiveRecord::Base
  belongs_to :e1, :class_name => 'Member', :foreign_key => "e1member_id"
  belongs_to :e2, :class_name => 'Member', :foreign_key => "e2member_id"
  belongs_to :driver, :class_name => 'Member', :foreign_key => "dmember_id"
  
  validates_presence_of :shiftdate, :shiftnum
  validates_numericality_of :shiftnum
  validates_inclusion_of :shiftnum, :in => 1..4
  validates_with ShiftMembersValidator #verifies shift has at least one member
  
  def Shift.find_all_in_month(thedate)
    firstdate = Date.new(thedate.year, thedate.month, 1)
    lastdate = Date.new(thedate.year, thedate.month, Time.days_in_month(thedate.month, thedate.year))
    Shift.find_all_between_days(firstdate, lastdate)
  end
  
  def Shift.find_or_create(thedate, shiftnum)
    shift = Shift.find_by_date_and_num(thedate, shiftnum)
    if shift.nil?
      shift = Shift.new
      shift.shiftdate = thedate.to_date
      shift.shiftnum = shiftnum.to_i
    end
    shift
  end
  
  def Shift.find_all_between_days(firstdate, lastdate)
    Shift.find(:all, :conditions => ["shiftdate >= ? and shiftdate <= ?", firstdate.to_date, lastdate.to_date], :order => 'shiftdate ASC, shiftnum ASC', :readonly => true)
  end
  
  def Shift.find_all_in_day(thedate, readonly = true)
    Shift.find(:all, :conditions => ["shiftdate = ?", thedate.to_date], :order => 'shiftnum ASC', :readonly => readonly)
  end
  
  def Shift.find_by_date_and_num(thedate, shiftnum)
    Shift.find(:first, :conditions => ["shiftdate = ? and shiftnum = ?", thedate.to_date, shiftnum])
  end
  
  def assign_member(position, member)
    position = position.downcase
    case position.downcase
      when 'e1' then self.e1 = member
      when 'e2' then self.e2 = member
      when 'd' || 'driver' then self.driver = member
    end
  end
  
  def assign_member_with_portable_number(position, portable_number)
    member = Member.get_with_portable_number(portable_number)
    assign_member(position, member)
  end
  
  def clear_member(position)
    assign_member(position, nil)
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
  
  def Shift.import_data(fname, clear_year = nil)
    if clear_year
      Shift.delete_all ["YEAR(shiftdate) = ?", clear_year]
    end
    
    File.open(fname, "r") do |infile|
      while (line = infile.gets)
        chunks = line.split
        if chunks.count == 15
          portable_name = chunks[1]
          shift_num = chunks[3]
          shift_date = chunks[5]
          position = chunks[13]
          
          if %w(1 2 3 4).include?(shift_num) && %w(E1 E2 D).include?(position)
            member = Member.get_or_create_member(portable_name)
            if member
              shift = Shift.find_or_create(shift_date, shift_num)
              shift.assign_member(position, member)
              shift.save
            end # if member
          end # if include?
        end # if chunks.count
      end # while
    end # File.open
  end # def import_data
end
