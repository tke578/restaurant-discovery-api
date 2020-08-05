  Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
  	namespace :v1 do
  		resources :users, only: [:index, :create]
  		post "/login", to: "users#login"
  		post "/search", to: "locations#search"
  		post "/add_favorite", to: "locations#add_favorite"
      delete "/remove_favorite", to: "locations#remove_favorite"
  	end
  end
end
