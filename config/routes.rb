Rails.application.routes.draw do
  default_url_options host: 'http://localhost'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :projects do
    resources :tasks, :except => [:index, :new] do
      match "change_status/:status" => 'tasks#change_status', :as => :change_status, :on => :member, :via => :all
      match 'start' => 'tasks#start', :as => 'start', :on => :member, :via => :all
      match 'stop' => 'tasks#stop', :as => 'stop', :on => :member, :via => :all
      resources :comments, :only => [:create, :destroy]
    end
  end


  root :to => 'projects#index'
end
