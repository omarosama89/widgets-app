Rails.application.routes.draw do
  root 'widgets#index'
  resources :authentication, only: [:new, :create] do
    collection do
      delete :revoke
      post :refresh
    end
  end
  resources :users, only: [:create, :show] do
    collection do
      get :new_change_password
      post :change_password
      post :reset_password
      get :edit
      put :update
    end
  end
  resources :widgets, only: [:new, :index, :create, :update, :destroy] do
    collection do
      get :my_widgets
      get :edit
      get :user_index
      get :list_widgets
    end
  end
  namespace :api do
    resources :users, only: [] do
      collection do
        get :check_email
      end
    end
    resources :widgets, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
