class CalendarController < ApplicationController
  before_filter :authenticate_member!
  
  def lionindex
  end

  def altindex
  end

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

  def show
  end

  def shiftedit
  end

  def shift_signup
  end

  def shiftsignup
  end

end
