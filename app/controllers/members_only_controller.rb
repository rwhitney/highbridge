class MembersOnlyController < ApplicationController
  before_filter :authenticate_member!
  
  def index
    @title = "Home Page"
    @desc = "MCA members-only home page"
    @date_general = MembersOnlyController.find_next_nth_day_of_week(3, 2)  # 2nd Wednesday of the month
    @date_board   = MembersOnlyController.find_next_nth_day_of_week(2, 1)  # 1st Tuesday of the month
  end
  
  def radio
    @title = "Radio Information"
    @desc = "MCA radio information page"
  end
  
  def radio_kenwood
    @title = "Kenwood Radio Information"
    @desc = "MCA Kenwood radio information page"
  end
  
  def radio_kenwooda
    @title = "Ambulance Radio Information"
    @desc = "MCA ambulance radio information page"
  end
  
  def radio_codes
    @title = "Radio Codes"
    @desc = "Boise County Sheriff radio codes"
  end

  def radio_alphabet
    @title = "Radio Alphabet"
    @desc = "Boise County Sheriff phonetic alphabet"
  end
  
  def photos
    @title = "Photos"
    @desc = "MCA member photos"
  end
  
  def roster
    @title = "Roster"
    @desc = "MCA member roster"
  end

protected
  def MembersOnlyController.find_next_nth_day_of_week(day_of_week, nth)
    today = Date.today
    date_this_month = MembersOnlyController.find_nth_day_of_week(today.year, today.month, day_of_week, nth)
    if date_this_month >= today
      date_this_month
    else
      next_month = Date.new(today.year, today.month, 1) + 1.month
      MembersOnlyController.find_nth_day_of_week(next_month.year, next_month.month, day_of_week, nth)
    end
  end
  
  def MembersOnlyController.find_nth_day_of_week(year, month, day_of_week, nth)
    first_day = Date.new(year, month, 1)
    weekday = first_day.wday
    if weekday <= day_of_week
      daynum = (day_of_week - weekday) + (nth-1) * 7 + 1
    else
      daynum = (7 - weekday) + (nth - 1) * 7 + day_of_week + 1
    end
    Date.new(year, month, daynum)
  end
end
