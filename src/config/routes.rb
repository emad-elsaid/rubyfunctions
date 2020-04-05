Rails.application.routes.draw do
  resources :users, only: [] do
    resources :functions do
      resources :comments, only: %i[create destroy]
    end
  end

  resource :github, only: [:new]
  resource :session, only: [:destroy]
  get 'timelines/latest', to: 'timelines#latest'

  root to: 'timelines#latest'
end
