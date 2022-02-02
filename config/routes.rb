Rails.application.routes.draw do
  

  devise_for :users
  resources :posts do
    resources :comments, only: [:create, :delete]
  end

  get "pages/:page" => "pages#show"

  root to: "pages#show", page: "home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
end
