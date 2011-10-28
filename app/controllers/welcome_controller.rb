class WelcomeController < ApplicationController
  def index
  end

  def generalinfo
  end

  def volunteerinfo
  end

  def links
  end

  def memberapp
    send_file "public/application.doc", :type => "application/msword", :disposition => "attachment"
  end
  
  def brochure
    send_file "public/MCABrochure.doc", :type => "application/msword", :disposition => "attachment"
  end
  
  def lifeflight
    send_file "public/images/lifeflight.jpg", :type => "image/jpg", :disposition => "inline"
  end
  
end
