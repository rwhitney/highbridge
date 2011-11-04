module MembersHelper
  MemberCategories = ["EMT", "First Responder", "Driver", "Non Call", "LOA", "Past Member"] 
  
  def MembersHelper.get_category_index(member)
    mc = MemberCategories.index(member.status)
    mc.nil? ? MemberCategories.index(member.training_level) : mc
  end
  
  def MembersHelper.get_category(member)
    mc = MembersHelper.get_category_index(member)
    MemberCategories[mc]
  end
  
  def MembersHelper.get_category_count(member_list, category)
    count = 0
    member_list.each do |member|
      member_category = MembersHelper.get_category(member)
      count += 1 if member_category == category
    end
    count
  end
  
  def MembersHelper.get_status(member)
    mc = MemberCategories.index(member.status)
    if mc
      member.training_level
    else
      member.status
    end
  end
  
  def MembersHelper.get_members_in_roster_order
  	@members = Member.find :all
  	@members.sort! { |x,y|
  	  xc = MembersHelper.get_category_index(x)
  	  yc = MembersHelper.get_category_index(y)
      [xc, x.last_name, x.first_name] <=> [yc, y.last_name, y.first_name]
  	}
  end
end
