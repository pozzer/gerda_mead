require 'sidekiq/web'

Rails.application.routes.draw do
  apipie

  root 'accounts#index'

  namespace :api do
    post :create, to: "receives#create"
    put :update, to: "receives#update"
  end

  mount Sidekiq::Web => '/sidekiq'
end
