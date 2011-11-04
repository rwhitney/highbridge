class CalendarController < ApplicationController
  before_filter :authenticate_member!
  
  def index
    @desc = "MCA Monthly Shift Calendar"
    @today = Date.today
    begin
      if params[:date]
        @caldate = params[:date].to_date
      else
        @caldate = Date.new(@today.year, @today.month, 1)
      end
    rescue
      @caldate = Date.new(@today.year, @today.month, 1)
    end

    @monthdays = Time.days_in_month(@caldate.month, @caldate.year)
    @numweeks = (@caldate.wday + @monthdays + 6) / 7  # calc the number of rows we need in the calendar
    @startday = @caldate - @caldate.wday
    @endday = @startday + (@numweeks * 7 - 1)
    @shifts = Shift.find_all_between_days(@startday, @endday)
    get_member_list @shifts
  end

  def shiftedit
    @formdate = Date.today
    begin
      @shiftdate = params[:date].to_date unless params[:date].nil?
    rescue
      @shiftdate = nil
    end
    if @shiftdate.nil? || @shiftdate < @formdate - 3.days
      redirect_to :action => 'index'
    else
      begin
        @shifts = Shift.find_all_in_day(@shiftdate)
      rescue
        @shifts = nil
      end
    end
    @caldate = @shiftdate
    get_member_list
    if current_member.admin?
      @portables = Member.get_all_portable_names
    end
  end
  
  def shiftedit2
    @sheets = ["shiftedit2"]
    @javascripts = ["calendar"]
    @today = Date.today
    @formdate = @today
    begin
      @shiftdate = params[:date].to_date unless params[:date].nil?
    rescue
      @shiftdate = nil
    end
    if @shiftdate.nil? || @shiftdate < @formdate - 3.days
      redirect_to :action => 'index'
    else
      begin
        @shifts = Shift.find_all_in_day(@shiftdate)
      rescue
        @shifts = nil
      end
    end
    @caldate = @shiftdate
    get_member_list
    if current_member.admin?
      @portables = Member.get_all_portable_names
    end
  end

  # used by non-admins to signup for shifts on a particular day
  def shiftsignup
    formdate = params[:received].to_date
    shiftdate = params[:shiftdate].to_date
    position = params[:position].split ','
    shiftnum = position[1].to_i if position.count == 2
    position = position[0]
    oldestdate = Date.today - 3.days
    if formdate >= oldestdate && shiftdate >= oldestdate && ['e1','e2','d'].include?(position.downcase) && (1..4).include?(shiftnum)
      shift = Shift.find_by_date_and_num shiftdate, shiftnum
      if shift.nil?
        shift = Shift.new
        shift.shiftdate = shiftdate
        shift.shiftnum = shiftnum
        shift.assign_member position, current_member
        shift.save
      else
        shift.assign_member position, current_member
        shift.save
      end
    end
    redirect_to :action => 'index', :thedate => shiftdate.to_s
  end
  
  # used by admins to change a days worth of shifts (POST)
  def shiftsignup2
    @today = Date.today
    oldestdate = @today - 3.days
    formdate = params[:received].nil? ? @today : params[:received].to_date
    shiftdate = params[:shiftdate].nil? ? nil : params[:shiftdate].to_date
    if shiftdate && formdate >= oldestdate && shiftdate >= oldestdate
      @caldate = shiftdate
      @shifts = Shift.find_all_in_day(@caldate, false)
      check_and_change_shift(1, params[:s1_emt1], params[:s1_emt2], params[:s1_d])
      check_and_change_shift(2, params[:s2_emt1], params[:s2_emt2], params[:s2_d])
      check_and_change_shift(3, params[:s3_emt1], params[:s3_emt2], params[:s3_d])
      check_and_change_shift(4, params[:s4_emt1], params[:s4_emt2], params[:s4_d])
    end
    redirect_to :action => 'index', :thedate => shiftdate.to_s
  end
  
protected
  def get_shift(shiftnum)
    @shifts.each do |shift|
      return shift if shift.shiftdate == @caldate && shift.shiftnum == shiftnum
    end
    shift = Shift.new
    shift.shiftdate = @caldate
    shift.shiftnum = shiftnum
    shift
  end

  def check_and_change_shift(shiftnum, emt1_portable_num, emt2_portable_num, driver_portable_num)
    shift = get_shift(shiftnum)
    shift_was_empty = shift.member_count == 0
    
    shift.assign_member_with_portable_number('e1', emt1_portable_num)
    shift.assign_member_with_portable_number('e2', emt2_portable_num)
    shift.assign_member_with_portable_number('d', driver_portable_num)
    
    shift_is_now_empty = shift.member_count == 0

    # Five cases...
    # 1. shift_was_empty && still is empty -> do nothing
    # 2. shift_was_emtpy && now has members -> save shift
    # 3. !shift_was_empty && was not changed -> do nothing
    # 4. !shift_was_empty && is now empty -> delete shift
    # 5. !shift_was_emtpy && has changed -> save shift
    
    if !shift_was_empty && shift_is_now_empty
      shift.destroy
    elsif !shift_is_now_empty
      shift.save
    end
  end
  
  # this is the sorted order of statuses for display
  MemberStatusList = ["Active","Probationary","Not Active","Associate","LOA","Past Member"]
  
  def get_member_list(monthly_shifts = Shift.find_all_in_month(@caldate))
    @members = Member.find :all
    @members.each do |member|
      member.monthly_total = Shift.calc_monthly_total(monthly_shifts, @caldate.month, member)
    end
    
    # doing a custom sort here so the members will be grouped by status in the order 
    # listed in MemberStatusList
    @members.sort! { |x,y|
      xc = MemberStatusList.index(x.status)
      xc = MemberStatusList.count if xc.nil?
      yc = MemberStatusList.index(y.status)
      yc = MemberStatusList.count if yc.nil?
      [xc, -x.monthly_total, x.portable_name] <=> [yc, -y.monthly_total, y.portable_name]
      }
  end

end
