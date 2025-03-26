# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "admin/prosecution_cases#index"

  namespace :admin do
    post "prosecution_conclusions/:id(/:publish_to)" => "prosecution_conclusions#create", as: :prosecution_conclusions
    get "court_applications" => "court_applications#index"

    resources :prosecution_cases, shallow: true do
      member do
        post "result/:hearing_id(/:publish_to)" => "prosecution_cases#result", as: :result_hearing
      end

      resources :defendants do
        resources :judicial_results
        resources :offences
        resources :defendants_court_applications do
          resources :judicial_results
          resource :court_application_type, only: %i[edit update]
          resources :respondents
        end
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
  post "/prosecutionCases/laaReference" \
    "/application/:applicationId" \
    "/subject/:subjectId" \
    "/offences/:offenceId" => "application_references#create", as: :application_reference
  post "/prosecutionCases/representationOrder" \
    "/cases/:prosecutionCaseId" \
    "/defendants/:defendantId" \
    "/offences/:offenceId" => "representation_orders#create", as: :representation_order
  post "/prosecutionCases/representationOrder" \
    "/applications/:applicationId" \
    "/subject/:subjectId" \
    "/offences/:offenceId" => "representation_orders#create"
  get "/hearing/results" => "hearings#show", as: :hearing
  get "/hearing/hearingLog" => "hearing_logs#show", as: :hearing_log
  get "/applications/:applicationId" => "court_application#index", as: :applications

  namespace :test do
    resources :prosecution_cases, only: [:create], path: "prosecution_cases" do
      resources :hearings, only: [] do
        post ":hearing_id/result(/:publish_to)", to: "prosecution_cases#result", on: :collection, as: :result
      end
      post ":id/publish(/:publish_to)", to: "prosecution_cases#publish", on: :collection, as: :publish
    end
  end
end
