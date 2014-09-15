Rails.application.routes.draw do

  resources :todos, except: [:new, :edit]
  
  match "*path", to: "sites#index", via: "get"

  root 'sites#index'
end
