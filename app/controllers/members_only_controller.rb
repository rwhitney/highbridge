class MembersOnlyController < ApplicationController
  before_filter :authenticate_member!
  
  BoardMeetingHour    = 19
  BoardMeetingMin     = 30
  BoardMeetingWeek    = 1     # 1st week of the month
  BoardMeetingWday    = 2     # Tuesday
  
  GeneralMeetingHour  = 19
  GeneralMeetingMin   = 30
  GeneralMeetingWeek  = 2     # 2nd week of the month
  GeneralMeetingWday  = 2     # Tuesday
  
  def index
    @title = "Home Page"
    @desc = "MCA members-only home page"
    @date_general = MembersOnlyController.find_next_nth_day_of_week(GeneralMeetingWday, 
      GeneralMeetingWeek, GeneralMeetingHour, GeneralMeetingMin)
    @date_board   = MembersOnlyController.find_next_nth_day_of_week(BoardMeetingWday, 
    BoardMeetingWeek, BoardMeetingHour, BoardMeetingMin)
    
    @time_general = Time.new(@date_general.year, @date_general.month, @date_general.day, GeneralMeetingHour, GeneralMeetingMin)
    @time_board   = Time.new(@date_board.year, @date_board.month, @date_board.day, BoardMeetingHour, BoardMeetingMin)
    @sheets = ["members_only"]
  end
  
  def board_notes
    @title = "Board Meeting Notes"
    @notes_list = MembersOnlyController.get_notes_assets("app/assets/documents/board")
    if params[:year] && params[:month]
      serve_up_asset(@notes_list, params[:year], params[:month])
    else
      @desc = "MCA board meeting notes page"
    end
  end
  
  def general_notes
    @title = "General Meeting Notes"
    @notes_list = MembersOnlyController.get_notes_assets("app/assets/documents/general")
    if params[:year] && params[:month]
      serve_up_asset(@notes_list, params[:year], params[:month])
    else
      @desc = "MCA general membership meeting notes page"
    end
  end
  
  def advisory_notes
    @title = "Advisory Board Meeting Notes"
    @notes_list = MembersOnlyController.get_notes_assets("app/assets/documents/advisory")
    if params[:year] && params[:month]
      serve_up_asset(@notes_list, params[:year], params[:month])
    else
      @desc = "MCA advisory board meeting notes page"
    end
  end
  
  def treasury_notes
    @title = "Treasury Notes"
    @notes_list = MembersOnlyController.get_notes_assets("app/assets/documents/treasury")
    if params[:year] && params[:month]
      serve_up_asset(@notes_list, params[:year], params[:month])
    else
      @desc = "MCA advisory board meeting notes page"
    end
  end
  
  def sops
    send_file "app/assets/documents/misc/SOPs.htm", :type => "text/html", :disposition => "inline"
  end
  
  def bylaws
    send_file "app/assets/documents/misc/Bylaws.htm", :type => "text/html", :disposition => "inline"
  end
  
  def ambulance_ops
    @title = "Ambulance Operations"
    @desc = "MCA ambulance operations page"
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
  
  def landing_zones
    @title = "Landing Zones"
    @desc = "MCA area landing zones"
  end
  
  def serve_file
    fname = params[:name]
    if fname && fname.downcase =~ /\.(pdf|doc|htm|jpg)\Z/
      ext = $1
      mime_type = case ext
        when "pdf" then "application/pdf"
        when "doc" then "application/word"
        when "htm" then "text/html"
        when "jpg" then "image/jpeg"
        else "text/plain"
      end
      send_file "app/assets/documents/misc/#{fname}", :type => mime_type, :disposition => (ext =~ /htm|jpg/ ? "inline" : "attachment")
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end
  
protected
  def serve_up_asset(assets, year, month)
    asset = MembersOnlyController.find_notes_asset(assets, year, month)
    if asset.nil?
      raise ActionController::RoutingError.new('Not Found')
    else
      mimetype = case asset[:type]
        when :htm then "text/html"
        when :pdf then "application/pdf"
        else "text/plain"
        end
      send_file asset[:fullname], :type => mimetype, :disposition => asset[:type] == :htm ? "inline" : "attachment"
    end
  end

  def MembersOnlyController.find_notes_asset(assets, year, month)
    assets.each do |dir_entry| 
      if dir_entry[:year] == year.to_i
        dir_entry[:list].each do |file_entry| 
          if file_entry[:month] == month.to_i
            return file_entry;
          end
        end
      end
    end
    nil
  end
  
  MonthAbbrevs = /jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec/

  def MembersOnlyController.get_notes_assets(path)
    dirlist = [];
    Dir.foreach(path) do |entry|
      if entry =~ /\A\d{4}\Z/
        subpath = "#{path}/#{entry}"
        filelist = [];
        Dir.foreach(subpath) do |subentry|
          subentry.downcase!
          if subentry =~ /\A\d{4}(#{MonthAbbrevs})(.*)\.(htm)\Z/ ||
            subentry =~ /\A\d{4}-\d{2}(#{MonthAbbrevs})(.*)\.(pdf)\Z/ ||
            subentry =~ /\A(#{MonthAbbrevs})(.*)\d{4}\.(htm)\Z/
            month_abbr = $1
            extra_name = $2
            file_type = $3
            unless extra_name =~ /(header|draft)/
              # we have an html file
              month = %w(jan feb mar apr may jun jul aug sep oct nov dec).index(month_abbr)
              o = { :month => month, :name => subentry, :fullname => "#{subpath}/#{subentry}", :type => file_type.to_sym }
              filelist.push o
            end
          end
        end
        
        if filelist.count > 0
          slist = filelist.sort { |x, y| x[:month] <=> y[:month] }
          o = { :year => entry.to_i, :list => slist }
          dirlist.push o
        end
      end
    end
    dirlist.sort! { |x,y| y[:year] <=> x[:year] }  # sort descending
  end

  def MembersOnlyController.find_next_nth_day_of_week(day_of_week, nth, hour, min)
    now = Time.now
    date_this_month = MembersOnlyController.find_nth_day_of_week(now.year, now.month, day_of_week, nth)
    time_this_month = Time.new(date_this_month.year, date_this_month.month, date_this_month.day, hour, min)
    if time_this_month >= now
      date_this_month
    else
      next_month = Date.new(now.year, now.month, 1) + 1.month
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
