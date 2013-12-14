Askyourquestion::Application.routes.draw do
  root :to => "homes#show"
  resources :questions, only: [:new,:create]
  resource :homes, only: [:show]
end
