Startrack::Application.routes.draw do

  devise_for :users

  resources :projects, :shallow => true  do
    resources :tasks, :except => [:index] do
      get :change_status, :on => :member
      resources :comments, :only => [:create, :destroy]
    end
  end

  root :to => "projects#index"
end
