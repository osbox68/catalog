Rails.application.routes.draw do
  devise_for :users
  resources :products
  resources :categories
  post "/reactions", to: "reactions#user_reaction", as: "user_reaction"
  get "/my_reactions", to: "reactions#product_with_reactions", as: "my_reactions"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "products#index"

end
