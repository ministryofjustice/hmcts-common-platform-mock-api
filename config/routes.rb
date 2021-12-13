# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :prosecution_cases, shallow: true do
      member do
        post "result/:hearing_id(/:publish_to)" => "prosecution_cases#result", as: :result_hearing
      end

      resources :defendants do
        resources :judicial_results
        resources :offences
      end

      resources :hearings, except: [:index] do
        resources :hearing_days
        resources :court_applications do
          resources :judicial_results
          resource :court_application_type, only: %i[edit update]
          resources :respondents
        end

        member do
          post "offences/:offence_id/pleas" => "pleas#create", as: :add_plea
          post "offences/:offence_id/allocation_decisions" => "allocation_decisions#create", as: :add_allocation_decision
          post "offences/:offence_id/judicial_results" => "judicial_results#create", as: :add_judicial_result
          post "offences/:offence_id/verdicts" => "verdicts#create", as: :add_verdict
        end
      end
    end
  end

  resources :status, only: [:index]

  resources :prosecution_cases, path: "/prosecutionCases", only: [:index]

  post "/prosecutionCases/laaReference" \
    "/cases/:prosecutionCaseId" \
    "/defendant/:defendantId" \
    "/offences/:offenceId" => "laa_references#create", as: :laa_reference
  post "/prosecutionCases/representationOrder" \
    "/cases/:prosecutionCaseId" \
    "/defendants/:defendantId" \
    "/offences/:offenceId" => "representation_orders#create", as: :representation_order
  get "/hearing/results" => "hearings#show", as: :hearing
  get "/hearing/hearingLog" => "hearings#log", as: :hearing_log
end
