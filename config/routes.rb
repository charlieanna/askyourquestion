Askyourquestion::Application.routes.draw do
  get "votes/create"
  get "votes/destroy"
  devise_for :users
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
end
