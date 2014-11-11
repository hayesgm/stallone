Rails.application.routes.draw do

  # Verifications
  post 'verifications/new'
  post 'verifications/confirm'

  # Users
  get  'users/check'
  post 'users/initialize_keys'
  post 'users/spot' => 'users#add_spot'
  post 'users/spots' => 'users#add_spots'

  # Session
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#logout'

  # Account
  get '/account(/:page)' => 'accounts#home', as: :account

  # Stream
  get '/stream' => 'home#stream', format: 'text'

  # Main Pages
  get '/done' => 'home#done', as: :done
  get '/privacy' => 'home#privacy', as: :privacy
  get '/tos' => 'home#tos', as: :tos
  
  # Demo?
  get 'demo' => 'demos#new', as: :demo
  post 'demo' => 'demos#create'

  root 'home#home'
  
end
