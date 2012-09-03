class WelcomeController < ApplicationController
  # no authentication required here - this is for the public
  
  def index
    @members = Member.get_all_but_past
    
    @emt_count = 0
    @emr_count = 0
    @driver_count = 0
    @members.each do |member|
      case member.training_level
        when 'EMT' then @emt_count += 1
        when 'EMR' then @emr_count += 1
        when 'Driver' then @driver_count += 1
      end
    end
    
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
    send_file "app/assets/documents/misc/App-Membership-Application.pdf", :type => "application/pdf", :disposition => "attachment"
  end
  
  def providerapp
    send_file "app/assets/documents/misc/App-Initial-Provider-Application-July-2011.pdf", :type => "application/pdf", :disposition => "attachment"
  end
  
  def reciprocityapp
    send_file "app/assets/documents/misc/App-Reciprocity-Application.pdf", :type => "application/pdf", :disposition => "attachment"
  end
  
  def brochure
    send_file "app/assets/documents/misc/MCABrochure.pdf", :type => "application/pdf", :disposition => "attachment"
  end
  
  def lifeflight
    send_file "app/assets/images/lifeflight.jpg", :type => "image/jpg", :disposition => "inline"
  end
end
