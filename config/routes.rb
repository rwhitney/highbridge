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
  get "members_only/roster"

  get "calendar/index"
  get "calendar/shiftedit"
  post "calendar/shiftsignup"

  resources :shifts
  resources :members
end
