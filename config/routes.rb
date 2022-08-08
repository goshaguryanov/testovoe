Rails.application.routes.draw do
  resource :expense, only: :create
  resource :income, only: :create
  resource :report, only: :create
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
