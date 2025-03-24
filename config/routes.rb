Rails.application.routes.draw do
  get "/signup", to: "users#new"   # Display sign-up form
  post "/signup", to: "users#create" # Handle form submission
  resource :session
  resources :passwords, param: :token
  resources :users, only: [:new, :create]
  get "up" => "rails/health#show", as: :rails_health_check
  root "pages#home"
  get "dashboard", to: "pages#dashboard"
  resources :todo_lists do
    # Tasks CRUD inside TodoLists
    resources :tasks, except: [:show]
  end
end
