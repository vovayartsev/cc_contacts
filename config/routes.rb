ContactSync::Application.routes.draw do
  root 'contacts#index'

  resources :contacts, :only => [:show, :index] do
    collection do
      get :available
    end
    member do
      post :import
    end
  end

  get "auth/google_oauth2/callback" => "sessions#create"
  get "auth/failure" => "sessions#auth_failure", :as => :auth_failure
  get "login" => "sessions#new", :as => :login

  # to help establish session in dev environment
  get "login/fake" => "sessions#fake", :as => :fake_login
end
