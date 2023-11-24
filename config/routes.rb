Rails.application.routes.draw do

  resources :indicators do
    resources :indicator_trackings
  end

  resources :users do
    collection do
      get :profile
      patch :update_profile
    end
  end

  scope '/auth' do
    devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'users/passwords' }
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "dashboard#index"
end
