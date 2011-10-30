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
    @members = Member.find :all
    for member in @members do
      member.monthly_total = Shift.calc_monthly_total(@shifts, @caldate.month, member)
    end
    @members = @members.sort_by { |m| [m.status, -m.monthly_total] }
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
  end

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

end
