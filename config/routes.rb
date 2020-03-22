Rails.application.routes.draw do
  root 'widgets#index'
  resources :authentication, only: [:new, :create] do
    collection do
      post :revoke
      post :refresh
    end
  end
  resources :users, only: [:new, :create] do
    collection do
      get :new_change_password
      post :change_password
    end
  end
  resources :widgets, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
