# frozen_string_literal: true

Rails.application.routes.draw do
  resources :matches, only: %i[index show create update]
  resources :countries, only: %i[show]
end
