# frozen_string_literal: true

Rails.application.routes.draw do
  resources :status, only: [:index]

  resources :prosecution_cases, path: '/search/case/prosecutionCases', only: [:index]

  post '/record/laareference/progression-command-api'\
    '/command/api/rest/progression/laaReference'\
    '/cases/:prosecutionCaseId'\
    '/defendants/:defendantId'\
    '/offences/:offenceId' => 'laa_references#record_reference', as: :laa_reference
  post '/receive/representation/progression-command-api'\
    '/command/api/rest/progression/representationOrder' \
    '/cases/:prosecutionCaseId' \
    '/defendants/:defendantId' \
    '/offences/:offenceId' => 'laa_references#record_representation_order', as: :representation_order
  get '/hearing/result/LAAGetHearingHttpTrigger' => 'hearings#show', as: :hearing
end
