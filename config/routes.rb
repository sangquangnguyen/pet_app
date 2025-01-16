Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    devise_for :users, controllers: { sessions: 'api/users/sessions', registrations: 'api/users/registrations' }
    resources :blogs
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
