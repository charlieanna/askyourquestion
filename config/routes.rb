Askyourquestion::Application.routes.draw do
  devise_for :users
  root :to => "homes#show"
  resources :questions, only: [:create]
  resource :homes, only: [:show]
end
