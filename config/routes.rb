Highbridge::Application.routes.draw do
  # See how all your routes lay out with "rake routes"
  root :to => 'welcome#index'

  get "welcome/index"

  get "welcome/generalinfo"

  get "welcome/volunteerinfo"

  get "welcome/links"
  
  get "welcome/memberapp"
  
  get "welcome/brochure"
  
  get "welcome/lifeflight"

  get "members_only/index"

  get "calendar/lionindex"

  get "calendar/altindex"

  get "calendar/index"

  get "calendar/show"

  get "calendar/shiftedit"

  get "calendar/shift_signup"

  get "calendar/shiftsignup"

  resources :shifts

  resources :members

end
