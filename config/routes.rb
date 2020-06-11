# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :prosecution_cases
  end
  resources :status, only: [:index]

  resources :prosecution_cases, path: '/prosecutionCases', only: [:index]

  post '/progression-command-api' \
    '/command/api/rest/progression/laaReference' \
    '/cases/:prosecutionCaseId' \
    '/defendants/:defendantId' \
    '/offences/:offenceId' => 'laa_references#record_reference', as: :laa_reference
  post '/progression-command-api' \
    '/command/api/rest/progression/representationOrder' \
    '/cases/:prosecutionCaseId' \
    '/defendants/:defendantId' \
    '/offences/:offenceId' => 'laa_references#record_representation_order', as: :representation_order
  get '/LAAGetHearingHttpTrigger' => 'hearings#show', as: :hearing
  get '/LAAGetHearingEventLogHttpTriggerFast' => 'hearings#log', as: :hearing_log
end
