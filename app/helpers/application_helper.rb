module ApplicationHelper
  def utc_string(fortime = Time.now)
    fortime.utc.strftime("%a, %d %b %Y %H:%M:%S GMT")
  end
  
  def utc_string_tomorrow
    utc_string(Time.now + 1.day)
  end
end
