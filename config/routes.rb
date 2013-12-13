Askyourquestion::Application.routes.draw do
  root :to => "questions#show"
  resources :question,only: [:new,:create]
end
