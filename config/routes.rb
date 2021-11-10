# frozen_string_literal: true

Rails.application.routes.draw do
  post 'authenticate', to: 'authentication#authenticate'
  resources :transactions, only: %i[create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
