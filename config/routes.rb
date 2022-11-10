Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users
  
  namespace :user do
    root :to => "scheduler#index"
  end
  
  resources :scheduler, only: [:index] do
    collection do
      get 'organization_routes', to: 'scheduler#organization_routes'
      post 'assign_route', to: 'scheduler#assign_route'
    end
  end

  # Defines the root path route ("/")
  root 'scheduler#index'
end
