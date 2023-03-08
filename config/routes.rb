Rails.application.routes.draw do
  get '/sentences', to: 'sentence#index'
  get '/sentence/:id', to: 'sentence#show' 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "sentence#index"
end
