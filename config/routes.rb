AthletePreneur::Application.routes.draw do
  resources :posts

  match '/auth/:provider/callback' => 'authentications#create'
  devise_for :users, :controllers => {:registrations => 'registrations'}
  resources :projects  
  resources :authentications
  root :to => "posts#index"
end
