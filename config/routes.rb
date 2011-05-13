Startrack::Application.routes.draw do
  devise_for :users

  resources :projects
  resources :stories
  resources :tasks

  root :to => "home#index"
end
