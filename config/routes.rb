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
      post :reset_password
    end
  end
  resources :widgets, only: [:index] do
    collection do
      get :my_widgets
    end
  end
  namespace :api do
    resources :users, only: [] do
      collection do
        get :check_email
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
