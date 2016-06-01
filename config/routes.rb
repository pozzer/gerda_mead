#require 'sidekiq/web'

Rails.application.routes.draw do
  apipie

  root 'homepages#index'

  namespace :api do
    post :create, to: "receives#create"
    put :update, to: "receives#update"
  end

  resources :homepages, only: :index

  #mount Sidekiq::Web => '/sidekiq'
end
