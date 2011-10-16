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
      match "verify_user" => "registrations#verify_user", :as => "verify_user"
      match "update_verify_user" => "registrations#update_verify_user", :as => "update_verify_user"
      match "admin_verify_user" => "registrations#admin_verify_user", :as => "admin_verify_user"
      match "admin_update_verify_user" => "registrations#admin_update_verify_user", :as => "admin_update_verify_user"
  end
  
  match "main_search" => "posts#main_search"
end
