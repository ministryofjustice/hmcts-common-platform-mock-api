# frozen_string_literal: true

Rails.application.routes.draw do
  resources :status, only: [:index]

  resources :prosecution_cases, path: 'prosecutionCases', only: [:index] do
    collection do
      put 'laaReference/:id' => 'laa_references#record_reference', as: :laa_reference
      put 'representationOrder/:id' => 'laa_references#record_representation_order', as: :representation_order
    end
  end
  resources :hearings, path: 'hearing/results', only: [:show], param: :hearingId
end
