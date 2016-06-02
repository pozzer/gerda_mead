#require 'sidekiq/web'

Rails.application.routes.draw do
  apipie

  root 'questions#index'

  namespace :api do
    post :create, to: "receives#create"
    put :update, to: "receives#update"
  end

  resources :questions, only: [:index,:show]
  resources :profiles, only: :index

  #mount Sidekiq::Web => '/sidekiq'
end
