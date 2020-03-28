Rails.application.routes.draw do
  resources :functions
  resource :github, only: [:new]
  resource :session, only: [:destroy]

  root to: 'functions#index'
end
