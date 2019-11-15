# frozen_string_literal: true

Rails.application.routes.draw do
  resources :status, only: [:index]

  resources :prosecution_cases, path: 'prosecutionCases', only: [:index] do
    collection do
      put 'laaReference/:id' => 'laa_references#record', as: :laa_reference
    end
  end
  resources :hearings, path: 'hearing/results', only: [:show], param: :hearingId
end
