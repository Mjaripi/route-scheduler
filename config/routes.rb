Rails.application.routes.draw do
  devise_for :users
  namespace :user do
    root :to => "welcome#index"
  end

  get 'scheduler/index'
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'
end
