module WelcomeHelper
  def title
    base_title = "Mores Creek Ambulance"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
