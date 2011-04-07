Startrack::Application.routes.draw do
  resources :projects
  devise_for :users
 
  root :to => "home#index"

end

