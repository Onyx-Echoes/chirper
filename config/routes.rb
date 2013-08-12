Chirper::Application.routes.draw do
  root :to => 'chirps#index'

  match '/register' => 'users#new', :as => :register, :via => :get
  match '/login' => 'users#login', :as => :login, :via => :get
  match '/login' => 'users#create_session', :as => :create_session, :via => :post
  match '/logout' => 'users#logout', :as => :logout, :via => :get

  resources :chirps do
    collection do
      get "listen"
    end
  end

  resources :users
end
