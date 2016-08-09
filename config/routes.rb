Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  root to: 'welcome#index'

  resources :games, only: [:create, :show]
  resources :questions, only: :create
end
