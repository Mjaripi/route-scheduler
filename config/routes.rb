Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users
  
  namespace :user do
    root :to => "home#index"
  end

  resources :home, only: [:index]
  
  resources :scheduler, only: [:index] do
    collection do
      post 'assign_route', to: 'scheduler#assign_route'
    end
  end

  # Defines the root path route ("/")
  root 'home#index'
end
