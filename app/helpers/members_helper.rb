module MembersHelper
  MemberCategories = ["EMT", "EMR", "Driver", "Non Call", "LOA", "Past Member"] 
  
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
  
  def MembersHelper.get_status_count(member_list, status)
    count = 0
    member_list.each do |member|
      count += 1 if member.status == status
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
  
  def MembersHelper.get_members_in_roster_order(current_member)
    if current_member.admin?
  	  @members = Member.find :all
  	else
  	  @members = Member.get_all_but_past
  	end
  	  
  	@members.sort! { |x,y|
  	  xc = MembersHelper.get_category_index(x)
  	  yc = MembersHelper.get_category_index(y)
      [xc, x.last_name, x.first_name] <=> [yc, y.last_name, y.first_name]
  	}
  end
  
  def MembersHelper.get_members_in_compliance_order(prev_month_shifts, prev_month, last_month_shifts, last_month)
    @members = Member.get_all_but_past
    
    @members.each do |member|
      member.last_total = Shift.calc_monthly_total(last_month_shifts, last_month.month, member)
      member.prev_total = Shift.calc_monthly_total(prev_month_shifts, prev_month.month, member)
      member.monthly_total = member.last_total + member.prev_total
    end
    
    @members.sort! { |x,y| 
      [x.status, -x.monthly_total, x.last_name, x.first_name] <=> [y.status, -y.monthly_total, y.last_name, y.first_name]
      }
  end
end
