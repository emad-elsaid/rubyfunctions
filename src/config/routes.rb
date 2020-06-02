Rails.application.routes.draw do
  resources :users, only: [] do
    resources :functions do
      resources :comments, only: %i[create edit update destroy]
      resource :like, only: %i[create destroy]
      resource :save, only: %i[create destroy]
    end
    resources :saves, only: :index
    resource :followerships, only: %i[create destroy]
    get :followers, action: :index, controller: :followerships
  end

  resource :github, only: [:new]
  resource :session, only: [:destroy]

  resources :notifications, only: %i[show index] do
    post :read_all, as: :read_all, on: :collection
  end
  resources :tags, only: %i[show index]

  get 'timelines/latest', to: 'timelines#latest'
  get 'timelines/liked', to: 'timelines#liked'
  get 'timelines/commented', to: 'timelines#commented'
  get 'timelines/saved', to: 'timelines#saved'
  get 'timelines/contributors', to: 'timelines#contributors'

  root to: 'timelines#latest'
end
