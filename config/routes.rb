# See how all your routes lay out with "rake routes"
Highbridge::Application.routes.draw do
  devise_for :members, :path_prefix => 'd'

  root :to => 'welcome#index'

  get "welcome/index"
  get "welcome/generalinfo"
  get "welcome/volunteerinfo"
  get "welcome/links"
  get "welcome/memberapp"
  get "welcome/brochure"
  get "welcome/lifeflight"

  get "members_only/index"
  get "members_only/radio"
  get "members_only/radio_kenwood"
  get "members_only/radio_kenwooda"
  get "members_only/radio_codes"
  get "members_only/radio_alphabet"
  get "members_only/photos"
  get "members_only/landing_zones"
  get "members_only/board_notes"
  get "members_only/general_notes"
  get "members_only/advisory_notes"
  get "members_only/treasury_notes"
  get "members_only/sops"
  get "members_only/bylaws"
  get "members_only/ambulance_ops"
  get "members_only/serve_file"

  get "calendar/index"
  get "calendar/shiftedit"
  get "calendar/shiftedit2"
  post "calendar/shiftsignup"
  post "calendar/shiftsignup2"
  
  get "members/compliance"

  resources :shifts
  resources :members
end
