# frozen_string_literal: true

Rails.application.routes.draw do
  resources :status, only: [:index]

  resources :prosecution_cases, path: 'prosecutionCases', only: [:index]
end
