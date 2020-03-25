Rails.application.routes.draw do
  resources :functions
  root to: 'functions#index'
end
