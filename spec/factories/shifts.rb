FactoryGirl.define do
#  t.date     "shiftdate"
#  t.integer  "shiftnum"
#  t.integer  "e1member_id"
#  t.integer  "e2member_id"
#  t.integer  "dmember_id"

  factory :shift1, :class => Shift do
    shiftdate { Date.today }
    shiftnum 1
  end
  
  factory :shift2, :class => Shift do
    shiftdate { Date.today }
    shiftnum 2
  end
  
  factory :shift3, :class => Shift do
    shiftdate { Date.today }
    shiftnum 3
  end
  
  factory :shift4, :class => Shift do
    shiftdate { Date.today }
    shiftnum 4
  end
end