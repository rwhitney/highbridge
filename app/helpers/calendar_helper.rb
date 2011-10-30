module CalendarHelper
  def title
    base_title = "Mores Creek Calendar"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
