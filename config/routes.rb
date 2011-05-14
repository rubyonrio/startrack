Startrack::Application.routes.draw do

  devise_for :users

  resources :projects
  resources :stories
  resources :tasks
  resources :comments

  root :to => "projects#index"
end
