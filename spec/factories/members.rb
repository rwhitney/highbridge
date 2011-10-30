FactoryGirl.define do
  factory :member do
    fullname "Mini User"
    portablename "miniu999"
    portablenumber 999
    email "mini@comcast.net"
    status "Active"           # "Associate", "Active", "Probationary"
    password "fritz1234"
    admin false
  end
  
  factory :admin, :class => Member do
    fullname "Big Daddy"
    portablename "bigd998"
    portablenumber 998
    email "bigd@aol.com"
    status "Active"           # "Associate", "Active", "Probationary"
    password "Zackomoto"
    admin true
  end
  
  factory :russ, :class => Member do
    fullname "Russ Whitney"
    portablename "russw08"
    portablenumber 8
    email "russ@whitneyhome.com"
    streetaddress "56 Falcon Drive"
    city "Boise"
    zip "83716"
    area "HC/OS"
    homephone "367-9235"
    workphone nil
    cellorotherphone "991-4108"
    shirtsize "L"
    status "Probationary"                # "Associate", "Active", "Probationary"
    miscnotes "web admin"
    password "explorer"
    admin true
  end
  
  factory :lisa, :class => Member do
    fullname "Lisa Whitney"
    portablename "lisaw07"
    portablenumber "7"
    email "lisa@whitneyhome.com"
    streetaddress "56 Falcon Drive"
    city "Boise"
    zip "83716"
    area "HC/OS"
    homephone "367-9235"
    workphone "367-9235"
    cellorotherphone "367-9235"
    shirtsize "M"
    status "Probationary"                # "Associate", "Active", "Probationary"
    miscnotes "EMT-B"
    password "password"
    admin false
  end

  factory :drew, :class => Member do
    fullname "Drew Bodie"
    portablename "drew44"
    portablenumber 44
    email "drewbodie2002@yahoo.com"
    streetaddress "5 Buckboard Place"
    city "Boise"
    zip "83716"
    area "WR"
    homephone "344-2243"
    workphone nil
    cellorotherphone nil
    shirtsize nil
    status "Active"                    # "Associate", "Active", "Probationary"
    miscnotes "President"
    password "password"
    admin true
  end

  factory :paul, :class => Member do
    fullname "Paul Bucca"
    portablename "paulb31"
    portablenumber 31
    email "pjbucca@msn.com"
    streetaddress "11 Forst Drive"
    city "Boise"
    zip "83716"
    area "WR"
    homephone "409-3962"
    workphone nil
    cellorotherphone nil
    shirtsize nil
    status "Active"                      # "Associate", "Active", "Probationary"
    miscnotes "WRFPD/Chassis Officer"
    password "password"
    admin false
  end

  factory :dennis, :class => Member do
    fullname "Dennis Bradshaw"
    portablename "dennisb01"
    portablenumber 1
    email "bd_team@juno.com"
    streetaddress "136 Gold Fork Ridge Rd"
    city "Boise"
    zip "83716"
    area "CC"
    homephone "392-2288"
    workphone nil
    cellorotherphone nil
    shirtsize nil
    status "Active"                      # "Associate", "Active", "Probationary"
    miscnotes "Adv. Board Rep."
    password "password"
    admin true
  end
end