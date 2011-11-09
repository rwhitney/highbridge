FactoryGirl.define do
  factory :member do
    full_name "Mini User"
    first_name "Mini"
    last_name "User"
    portable_name "miniu999"
    portable_number 999
    training_level "EMR"
    email "mini@comcast.net"
    status "Active"           # "Associate", "Active", "Probationary"
    password "fritz1234"
    admin false
  end
  
  factory :admin, :class => Member do
    full_name "Big Daddy"
    first_name "Big"
    last_name "Daddy"
    portable_name "bigd998"
    portable_number 998
    training_level "EMT"
    email "bigd@aol.com"
    status "Active"           # "Associate", "Active", "Probationary"
    password "Zackomoto"
    admin true
  end
  
  factory :russ, :class => Member do
    full_name "Russ Whitney"
    first_name "Russ"
    last_name "Whitney"
    training_level "Driver"
    portable_name "russw08"
    portable_number 8
    email "russ@whitneyhome.com"
    street_address "56 Falcon Drive"
    city "Boise"
    zip "83716"
    area "HC/OS"
    home_phone "367-9235"
    work_phone nil
    cell_or_other_phone "991-4108"
    shirt_size "L"
    status "Probationary"                # "Associate", "Active", "Probationary"
    misc_notes "web admin"
    password "explorer"
    admin true
  end
  
  factory :lisa, :class => Member do
    full_name "Lisa Whitney"
    first_name "Lisa"
    last_name "Whitney"
    training_level "EMT"
    portable_name "lisaw07"
    portable_number "7"
    email "lisa@whitneyhome.com"
    street_address "56 Falcon Drive"
    city "Boise"
    zip "83716"
    area "HC/OS"
    home_phone "367-9235"
    work_phone "367-9235"
    cell_or_other_phone "367-9235"
    shirt_size "M"
    status "Probationary"                # "Associate", "Active", "Probationary"
    misc_notes "EMT-B"
    password "password"
    admin false
  end

  factory :drew, :class => Member do
    full_name "Drew Bodie"
    first_name "Drew"
    last_name "Bodie"
    training_level "EMR"
    portable_name "drew44"
    portable_number 44
    email "drewbodie2002@yahoo.com"
    street_address "5 Buckboard Place"
    city "Boise"
    zip "83716"
    area "WR"
    home_phone "344-2243"
    work_phone nil
    cell_or_other_phone nil
    shirt_size nil
    status "Active"                    # "Associate", "Active", "Probationary"
    misc_notes "President"
    password "password"
    admin true
  end

  factory :paul, :class => Member do
    full_name "Paul Bucca"
    first_name "Paul"
    last_name "Bucca"
    training_level "EMT"
    portable_name "paulb31"
    portable_number 31
    email "pjbucca@msn.com"
    street_address "11 Forst Drive"
    city "Boise"
    zip "83716"
    area "WR"
    home_phone "409-3962"
    work_phone nil
    cell_or_other_phone nil
    shirt_size nil
    status "Active"                      # "Associate", "Active", "Probationary"
    misc_notes "WRFPD/Chassis Officer"
    password "password"
    admin false
  end

  factory :dennis, :class => Member do
    full_name "Dennis Bradshaw"
    first_name "Dennis"
    last_name "Bradshaw"
    training_level "EMT"
    portable_name "dennisb01"
    portable_number 1
    email "bd_team@juno.com"
    street_address "136 Gold Fork Ridge Rd"
    city "Boise"
    zip "83716"
    area "CC"
    home_phone "392-2288"
    work_phone nil
    cell_or_other_phone nil
    shirt_size nil
    status "Active"                      # "Associate", "Active", "Probationary"
    misc_notes "Adv. Board Rep."
    password "password"
    admin true
  end
end