Rails.application.routes.draw do
  resources :rides
  resources :attractions
  resources :users

  root 'sessions#new'
  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  post '/signout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
