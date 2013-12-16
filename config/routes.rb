Askyourquestion::Application.routes.draw do
  devise_for :admins, :controllers => { :sessions => "admin/sessions" }
  # mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  
  get "votes/create"
  get "votes/destroy"
  resources :events,only: [:new,:create,:show] do
    resources :questions, only: [:create,:index] do
      post 'vote' => 'votes#create'
      delete 'vote' => 'votes#destroy'
    end
  end
  resources :users do
    post 'join' => 'subscribers#create'
    # delete 'follow' => 'following_relationships#destroy'
  end
  root :to => "homes#show"
   get "home" =>  "homes#show"
  resources :questions, only: [:create] do
    post 'vote' => 'votes#create'
    delete 'vote' => 'votes#destroy'
  end
  resource :homes, only: [:show]
  get  'auth/:provider/callback' => 'sessions#create',:as => 'login'
  delete 'logout' => 'sessions#destroy'
  get  'auth/failure' => 'sessions#failure'
  resource :session,only: [:create]
  resources :subscribers,only: [:new,:create,:destroy]
end
