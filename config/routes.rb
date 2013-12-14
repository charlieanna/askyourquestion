Askyourquestion::Application.routes.draw do
  root :to => "homes#show"
  resources :questions, only: [:create]
  resource :homes, only: [:show]
end
