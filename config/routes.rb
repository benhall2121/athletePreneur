AthletePreneur::Application.routes.draw do
  resources :friendships

  resources :posts

  match '/auth/:provider/callback' => 'authentications#create'
  
  resources :authentications
  root :to => "posts#index"
  
  devise_for :users, :controllers => {:registrations => 'registrations'}
  
  devise_scope :user do
      match "users" => "registrations#index", :as => "users"
      match "show_user/:id" => "registrations#show", :as => "show_user"
  end
  
  match "main_search" => "posts#main_search"
end
