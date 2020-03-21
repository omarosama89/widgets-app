Rails.application.routes.draw do
  root 'authentication#new'
  resources :authentication, only: [:new, :create]
  resources :users, only: [:new, :create]
  resources :widgets, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
