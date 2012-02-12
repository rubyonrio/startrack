Startrack::Application.routes.draw do

  devise_for :users

  resources :projects do
    resources :tasks, :except => [:index, :new] do
      match "/change_status/:status_id" => "tasks#change_status", :as => :change_status, :on => :member
      match 'start' => 'tasks#start', :as => "start", :on => :member
      match 'stop' => 'tasks#stop', :as => "stop", :on => :member
      resources :comments, :only => [:create, :destroy]
    end
  end

  root :to => redirect("/users/sign_in")
end
