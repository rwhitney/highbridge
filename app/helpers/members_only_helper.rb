module MembersOnlyHelper
  def motitle
    base_title = "Mores Creek Members Only"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
