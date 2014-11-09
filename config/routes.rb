Rails.application.routes.draw do

  # Verifications
  post 'verifications/new'
  post 'verifications/confirm'

  # Users
  get  'users/check'
  post 'users/initialize_keys'
  post 'users/spots' => 'users#add_spot'

  get '/done' => 'home#done', as: :done
  get '/privacy' => 'home#privacy', as: :privacy
  get '/tos' => 'home#tos', as: :tos
  
  get 'demo' => 'demos#new', as: :demo
  post 'demo' => 'demos#create'

  root 'home#home'
  
end
