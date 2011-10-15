AthletePreneur::Application.routes.draw do
  resources :posts

  match '/auth/:provider/callback' => 'authentications#create'
  
  resources :projects  
  resources :authentications
  root :to => "posts#index"
  
  devise_for :users, :controllers => {:registrations => 'registrations'}
  
  devise_scope :user do
      match "users" => "registrations#index", :as => "users"
      match "show_user/:id" => "registrations#show", :as => "show_user"
  end
end
