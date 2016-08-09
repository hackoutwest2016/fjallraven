Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  root to: 'games#new'

  resources :games, only: [:create, :show, :new]

  get '/games/share/:id', to: 'games#share'

  resources :questions, only: :create
end
