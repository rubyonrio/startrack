Startrack::Application.routes.draw do

  devise_for :users

  resources :projects do
    resources :tasks do
      resources :comments
    end
  end

  root :to => "projects#index"
end
