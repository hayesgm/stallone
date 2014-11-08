Rails.application.routes.draw do

  get 'verifications/new'

  get 'verifications/confirm'

  get '/done' => 'home#done', as: :done
  get '/privacy' => 'home#privacy', as: :privacy
  get '/tos' => 'home#tos', as: :tos
  
  get 'demo' => 'demos#new', as: :demo
  post 'demo' => 'demos#create'

  root 'home#home'
  
end
