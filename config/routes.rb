Startrack::Application.routes.draw do

  devise_for :users

  resources :projects, :shallow => true  do
    resources :tasks, :except => [:index] do
      resources :comments, :only => [:create, :destroy]
    end
  end

  root :to => "projects#index"
end
