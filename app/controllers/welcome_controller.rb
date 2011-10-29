class WelcomeController < ApplicationController
  def index
    @desc = "Mores Creek Ambulance home page"
  end

  def generalinfo
    @title = "General Info"
    @desc = "MCA information page"
  end

  def volunteerinfo
    @title = "Volunteer Info"
    @desc = "MCA volunteer information page"
  end

  def links
    @title = "Links"
    @desc = "MCA links page"
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
