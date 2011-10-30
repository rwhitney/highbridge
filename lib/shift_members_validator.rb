class ShiftMembersValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:base] << "Shift must have at least one member!" unless has_a_member(record)
  end
  
private
  def has_a_member(record)
    record.e1member_id || record.e2member_id || record.dmember_id
  end
end