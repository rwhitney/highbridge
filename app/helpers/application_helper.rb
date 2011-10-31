module ApplicationHelper
  def title
    base_title = "Mores Creek Members Only"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def utc_string(fortime = Time.now)
    fortime.utc.strftime("%a, %d %b %Y %H:%M:%S GMT")
  end
  
  def utc_string_tomorrow
    utc_string(Time.now + 1.day)
  end

  def utc_string_yesterday
    utc_string(Time.now - 1.day)
  end

end
