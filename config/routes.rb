# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :prosecution_cases, shallow: true do
      member do
        post "result/:hearing_id(/:publish_to)" => "prosecution_cases#result", as: :result_hearing
      end

      resources :defendants do
        resources :offences
      end

      resources :hearings, except: [:index] do
        member do
          post "offences/:offence_id/pleas" => "pleas#create", as: :add_plea
          post "offences/:offence_id/allocation_decisions" => "allocation_decisions#create", as: :add_allocation_decision

          post "hearing_days" => "hearing_days#create", as: :add_hearing_days
          get "hearing_days/:hearing_day_id" => "hearing_days#show", as: :hearing_day
          get "hearing_days/:hearing_day_id/edit" => "hearing_days#edit", as: :edit_hearing_day
          patch "hearing_days/:hearing_day_id" => "hearing_days#update", as: :update_hearing_day
          delete "hearing_days/:hearing_day_id" => "hearing_days#delete", as: :delete_hearing_day

          post "offences/:offence_id/judicial_results" => "judicial_results#create", as: :add_judicial_result
          get "offences/:offence_id/judicial_results/:judicial_result_id" => "judicial_results#show", as: :judicial_result
          get "offences/:offence_id/judicial_results/:judicial_result_id/edit" => "judicial_results#edit", as: :edit_judicial_result
          patch "offences/:offence_id/judicial_results/:judicial_result_id" => "judicial_results#update", as: :update_judicial_result
          delete "offences/:offence_id/judicial_results/:judicial_result_id" => "judicial_results#delete", as: :delete_judicial_result
        end
      end
    end
  end

  resources :status, only: [:index]

  resources :prosecution_cases, path: "/prosecutionCases", only: [:index]

  post "/prosecutionCases/laaReference" \
    "/cases/:prosecutionCaseId" \
    "/defendant/:defendantId" \
    "/offences/:offenceId" => "laa_references#record_reference", as: :laa_reference
  post "/prosecutionCases/representationOrder" \
    "/cases/:prosecutionCaseId" \
    "/defendants/:defendantId" \
    "/offences/:offenceId" => "laa_references#record_representation_order", as: :representation_order
  get "/hearing/results" => "hearings#show", as: :hearing
  get "/hearing/hearingLog" => "hearings#log", as: :hearing_log
end
