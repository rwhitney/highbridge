class WelcomeController < ApplicationController
  def index
  end

  def generalinfo
    @title = "General Info"
  end

  def volunteerinfo
    @title = "Volunteer Info"
  end

  def links
    @title = "Links"
  end

  def memberapp
    send_file "app/assets/documents/application.doc", :type => "application/msword", :disposition => "attachment"
  end
  
  def brochure
    send_file "app/assets/documents/MCABrochure.doc", :type => "application/msword", :disposition => "attachment"
  end
  
  def lifeflight
    send_file "app/assets/images/lifeflight.jpg", :type => "image/jpg", :disposition => "inline"
  end
end
