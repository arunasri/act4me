Tweet2review::Application.routes.draw do

  match "/auth/:provider/callback" => "sessions#create"
  match "/admin"   => "sessions#admin",   :as => :admin
  match "/signout" => "sessions#destroy", :as => :signout

  match '/movies/:page' => 'movies#index', :constraints => { :page => /\d+/ }
  match '/movies/:id/:action/:page' => 'movies'

  resources :movies do

    collection do
      get :autocomplete
    end

    member do
      put :sync
      get :closest
      get :positive
      get :negative
      get :mixed
      get :fresh
      get :terminate
      get :edit_fresh
      get :edit_mixed
      get :edit_external
      get :edit_positive
      get :edit_terminate
      get :edit_negative
      get :edit_assesed
    end

    resources :keywords, :only => [ :create ]
  end

  resources :keywords, :only => [ :destroy ]

  root :to => "movies#index"
end
