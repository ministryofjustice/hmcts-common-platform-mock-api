# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_04_03_105947) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "address1", null: false
    t.string "address2"
    t.string "address3"
    t.string "address4"
    t.string "address5"
    t.string "postcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "allocation_decisions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "motReasonId"
    t.string "motReasonDescription"
    t.string "motReasonCode"
    t.datetime "allocationDecisionDate", precision: nil
    t.boolean "isSection22ALowValueShoplifting", default: false, null: false
    t.boolean "isDamageValueUnder5000", default: false, null: false
    t.boolean "isTreatedAsIndictableOnly", default: false, null: false
    t.boolean "sentencingIndicationRequested", default: false, null: false
    t.uuid "court_indicated_sentence_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sequenceNumber", default: 0, null: false
    t.uuid "offence_id", null: false
    t.uuid "hearing_id", null: false
    t.index ["court_indicated_sentence_id"], name: "index_allocation_decisions_on_court_indicated_sentence_id"
    t.index ["hearing_id"], name: "index_allocation_decisions_on_hearing_id"
    t.index ["offence_id"], name: "index_allocation_decisions_on_offence_id"
  end

  create_table "applicant_counsels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.string "firstName"
    t.string "middleName"
    t.string "lastName"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "hearing_id"
    t.index ["hearing_id"], name: "index_applicant_counsels_on_hearing_id"
  end

  create_table "applicants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "applicant_counsel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_counsel_id"], name: "index_applicants_on_applicant_counsel_id"
  end

  create_table "application_pleas", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "originating_hearing_id"
    t.uuid "delegated_powers_id", null: false
    t.uuid "application_id"
    t.string "plea_date"
    t.string "plea_value"
    t.uuid "lesser_or_alternative_offence_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["delegated_powers_id"], name: "index_application_pleas_on_delegated_powers_id"
    t.index ["lesser_or_alternative_offence_id"], name: "index_application_pleas_on_lesser_or_alternative_offence_id"
  end

  create_table "application_verdicts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "originating_hearing_id"
    t.uuid "application_id"
    t.string "verdict_date"
    t.uuid "verdict_type_id", null: false
    t.uuid "jurors_id", null: false
    t.uuid "lesser_or_alternative_offence_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jurors_id"], name: "index_application_verdicts_on_jurors_id"
    t.index ["lesser_or_alternative_offence_id"], name: "index_application_verdicts_on_lesser_or_alternative_offence_id"
    t.index ["verdict_type_id"], name: "index_application_verdicts_on_verdict_type_id"
  end

  create_table "approval_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "hearing_id"
    t.uuid "user_id"
    t.string "request_approval_time"
    t.string "approval_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "associated_people", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "person_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "defendant_id"
    t.uuid "court_application_party_id"
    t.bigint "master_defendant_id"
    t.index ["court_application_party_id"], name: "index_associated_people_on_court_application_party_id"
    t.index ["defendant_id"], name: "index_associated_people_on_defendant_id"
    t.index ["master_defendant_id"], name: "index_associated_people_on_master_defendant_id"
    t.index ["person_id"], name: "index_associated_people_on_person_id"
  end

  create_table "attendance_days", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "day", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "applicant_counsel_id"
    t.uuid "prosecution_counsel_id"
    t.uuid "defence_counsel_id"
    t.uuid "defendant_attendance_id"
    t.uuid "court_application_party_attendance_id"
    t.uuid "court_application_party_counsel_id"
    t.uuid "respondent_counsel_id"
    t.uuid "company_representatives_id"
    t.uuid "interpreter_intermediary_id"
    t.string "attendanceType"
    t.index ["applicant_counsel_id"], name: "index_attendance_days_on_applicant_counsel_id"
    t.index ["company_representatives_id"], name: "index_attendance_days_on_company_representatives_id"
    t.index ["court_application_party_attendance_id"], name: "index_attendance_days_on_court_application_party_attendance_id"
    t.index ["court_application_party_counsel_id"], name: "index_attendance_days_on_court_application_party_counsel_id"
    t.index ["defence_counsel_id"], name: "index_attendance_days_on_defence_counsel_id"
    t.index ["defendant_attendance_id"], name: "index_attendance_days_on_defendant_attendance_id"
    t.index ["interpreter_intermediary_id"], name: "index_attendance_days_on_interpreter_intermediary_id"
    t.index ["prosecution_counsel_id"], name: "index_attendance_days_on_prosecution_counsel_id"
    t.index ["respondent_counsel_id"], name: "index_attendance_days_on_respondent_counsel_id"
  end

  create_table "bail_statuses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.uuid "custody_time_limit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["custody_time_limit_id"], name: "index_bail_statuses_on_custody_time_limit_id"
  end

  create_table "box_hearing_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "court_centre_id"
    t.string "jurisdiction_type"
    t.string "application_due_date"
    t.string "virtual_appointment_time"
    t.boolean "send_appointment_letter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "committing_courts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "court_centre_id"
    t.string "court_house_type"
    t.string "court_house_code"
    t.string "court_house_name"
    t.string "court_house_short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_representatives", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.string "first_name"
    t.string "last_name"
    t.string "position"
    t.text "defendants", default: [], array: true
    t.text "attendance_days", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contact_numbers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "home"
    t.string "work"
    t.string "mobile"
    t.string "primaryEmail"
    t.string "secondaryEmail"
    t.string "fax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "court_application_cases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "prosecution_case_id"
    t.boolean "is_sjp"
    t.uuid "prosecution_case_identifier_id", null: false
    t.string "case_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "court_application_id"
    t.index ["court_application_id"], name: "index_court_application_cases_on_court_application_id"
    t.index ["prosecution_case_identifier_id"], name: "index_court_application_cases_on_prosecution_case_identifier_id"
  end

  create_table "court_application_hearings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "hearing_id"
    t.uuid "court_application_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["court_application_id"], name: "index_court_application_hearings_on_court_application_id"
    t.index ["hearing_id"], name: "index_court_application_hearings_on_hearing_id"
  end

  create_table "court_application_outcomes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "originatingHearingId"
    t.uuid "applicationId"
    t.datetime "applicationOutcomeDate", precision: nil
    t.uuid "application_outcome_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_outcome_type_id"], name: "index_court_application_outcomes_on_application_outcome_type_id"
  end

  create_table "court_application_parties", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "synonym"
    t.uuid "person_id"
    t.uuid "organisation_id"
    t.uuid "prosecuting_authority_id"
    t.uuid "representation_organisation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "court_application_party_counsel_id"
    t.boolean "summons_required"
    t.boolean "notification_required"
    t.uuid "master_defendant_id"
    t.boolean "appointment_notification_required"
    t.uuid "court_application_id"
    t.index ["court_application_id"], name: "index_court_application_parties_on_court_application_id"
    t.index ["court_application_party_counsel_id"], name: "application_parties_on_court_application_party_counsel_id"
    t.index ["master_defendant_id"], name: "index_court_application_parties_on_master_defendant_id"
    t.index ["organisation_id"], name: "index_court_application_parties_on_organisation_id"
    t.index ["person_id"], name: "index_court_application_parties_on_person_id"
    t.index ["prosecuting_authority_id"], name: "index_court_application_parties_on_prosecuting_authority_id"
    t.index ["representation_organisation_id"], name: "court_application_parties_on_rep_org_id"
  end

  create_table "court_application_party_attendances", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "court_application_party_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "hearing_id"
    t.index ["court_application_party_id"], name: "attendances_on_court_application_party_id"
    t.index ["hearing_id"], name: "index_court_application_party_attendances_on_hearing_id"
  end

  create_table "court_application_party_counsels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "applicationId"
    t.string "title"
    t.string "firstName"
    t.string "middleName"
    t.string "lastName"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "hearing_id"
    t.index ["hearing_id"], name: "index_court_application_party_counsels_on_hearing_id"
  end

  create_table "court_application_payments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "isFeePaid", default: false, null: false
    t.boolean "isFeeUndertakingAttached", default: false, null: false
    t.boolean "isFeeExempt", default: false, null: false
    t.string "paymentReference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "court_application_prosecution_cases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "prosecution_case_id", null: false
    t.uuid "court_application_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["court_application_id"], name: "idx_on_court_application_id_3321025573"
    t.index ["prosecution_case_id"], name: "idx_on_prosecution_case_id_a607638707"
  end

  create_table "court_application_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "linkType"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.string "category_code"
    t.string "jurisdiction"
    t.string "summons_template_type"
    t.string "breach_type"
    t.boolean "appeal_flag"
    t.boolean "applicant_appellant_flag"
    t.boolean "plea_applicable_flag"
    t.boolean "commr_of_oath_flag"
    t.boolean "court_of_appeal_flag"
    t.boolean "court_extract_avl_flag"
    t.boolean "prosecutor_third_party_flag"
    t.boolean "spi_out_applicable_flag"
    t.string "offence_active_order"
    t.string "code"
    t.string "legislation"
    t.string "valid_from"
    t.string "valid_to"
    t.string "listing_notif_template"
    t.string "boxwork_notif_template"
    t.string "type_welsh"
    t.string "legislation_welsh"
    t.string "hearing_code"
    t.string "resentencing_activation_code"
    t.string "prefix"
  end

  create_table "court_applications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "applicationReceivedDate", precision: nil
    t.string "applicationReference"
    t.uuid "court_application_party_id", null: false
    t.uuid "court_application_outcome_id"
    t.uuid "parentApplicationId"
    t.string "applicationParticulars"
    t.uuid "court_application_payment_id"
    t.datetime "applicationDecisionSoughtByDate", precision: nil
    t.string "applicationStatus"
    t.string "outOfTimeReasons"
    t.string "breachedOrder"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "hearing_id"
    t.uuid "court_application_type_id"
    t.uuid "defendant_id"
    t.string "result_code"
    t.string "short_code"
    t.index ["court_application_outcome_id"], name: "index_court_applications_on_court_application_outcome_id"
    t.index ["court_application_party_id"], name: "index_court_applications_on_court_application_party_id"
    t.index ["court_application_payment_id"], name: "index_court_applications_on_court_application_payment_id"
    t.index ["court_application_type_id"], name: "index_court_applications_on_court_application_type_id"
    t.index ["defendant_id"], name: "index_court_applications_on_defendant_id"
    t.index ["hearing_id"], name: "index_court_applications_on_hearing_id"
  end

  create_table "court_hearing_requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "hearing_type_id", null: false
    t.string "jurisdiction_type"
    t.string "listed_start_date_time"
    t.string "earliest_start_date_time"
    t.string "end_date"
    t.uuid "booking_reference"
    t.json "week_commencing_date"
    t.integer "estimate_minutes"
    t.uuid "court_centre_id"
    t.string "listing_directions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hearing_type_id"], name: "index_court_hearing_requests_on_hearing_type_id"
  end

  create_table "court_indicated_sentences", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "courtIndicatedSentenceTypeId"
    t.string "courtIndicatedSentenceDescription"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "court_order_offences", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "offence_id", null: false
    t.uuid "prosecution_case_id"
    t.uuid "prosecution_case_identifier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "court_order_id"
    t.index ["court_order_id"], name: "index_court_order_offences_on_court_order_id"
    t.index ["offence_id"], name: "index_court_order_offences_on_offence_id"
    t.index ["prosecution_case_identifier_id"], name: "index_court_order_offences_on_prosecution_case_identifier_id"
  end

  create_table "court_order_subjects", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "master_defendant_id"
    t.string "organisation_name"
    t.string "title"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "date_of_birth"
    t.string "address_line_1"
    t.string "pnc_id"
    t.string "cro_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "court_orders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "defendant_ids", default: [], array: true
    t.uuid "master_defendant_id"
    t.uuid "judicial_result_type_id"
    t.string "label"
    t.string "order_date"
    t.string "start_date"
    t.string "end_date"
    t.uuid "court_centre_id"
    t.uuid "ordering_hearing_id"
    t.boolean "is_sjp_order"
    t.boolean "can_be_subject_of_breach_proceedings"
    t.boolean "can_be_subject_of_variation_proceedings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cracked_ineffective_trials", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.string "reason_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "date"
  end

  create_table "custody_time_limits", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "timeLimit", precision: nil
    t.integer "daysSpent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "defence_counsels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.string "firstName"
    t.string "middleName"
    t.string "lastName"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "hearing_id"
    t.index ["hearing_id"], name: "index_defence_counsels_on_hearing_id"
  end

  create_table "defence_organisations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organisation_id", null: false
    t.string "laaContractNumber"
    t.string "sraNumber"
    t.string "barCouncilMembershipNumber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "associationStartDate", precision: nil
    t.datetime "associationEndDate", precision: nil
    t.string "fundingType"
    t.boolean "isAssociatedByLAA", default: false, null: false
    t.uuid "defendant_id"
    t.index ["defendant_id"], name: "index_defence_organisations_on_defendant_id"
    t.index ["organisation_id"], name: "index_defence_organisations_on_organisation_id"
  end

  create_table "defendant_aliases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.string "firstName"
    t.string "middleName"
    t.string "lastName"
    t.string "legalEntityName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "defendant_id"
    t.index ["defendant_id"], name: "index_defendant_aliases_on_defendant_id"
  end

  create_table "defendant_attendances", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "defendant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "hearing_id"
    t.index ["defendant_id"], name: "index_defendant_attendances_on_defendant_id"
    t.index ["hearing_id"], name: "index_defendant_attendances_on_hearing_id"
  end

  create_table "defendant_cases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "defendant_id"
    t.uuid "case_id"
    t.string "case_reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "master_defendant_id"
    t.index ["master_defendant_id"], name: "index_defendant_cases_on_master_defendant_id"
  end

  create_table "defendant_hearing_youth_markers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "prosecution_case_id", null: false
    t.uuid "defendant_id", null: false
    t.uuid "hearing_id"
    t.uuid "marker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["defendant_id"], name: "index_defendant_hearing_youth_markers_on_defendant_id"
    t.index ["hearing_id"], name: "index_defendant_hearing_youth_markers_on_hearing_id"
    t.index ["marker_id"], name: "index_defendant_hearing_youth_markers_on_marker_id"
    t.index ["prosecution_case_id"], name: "index_defendant_hearing_youth_markers_on_prosecution_case_id"
  end

  create_table "defendant_judicial_results", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "master_defendant_id"
    t.uuid "judicial_result_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["judicial_result_id"], name: "index_defendant_judicial_results_on_judicial_result_id"
  end

  create_table "defendants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "numberOfPreviousConvictionsCited"
    t.string "prosecutionAuthorityReference"
    t.string "witnessStatement"
    t.string "witnessStatementWelsh"
    t.string "mitigation"
    t.string "mitigationWelsh"
    t.string "defendable_type", null: false
    t.uuid "defendable_id", null: false
    t.string "croNumber"
    t.string "pncId"
    t.string "mergedProsecutionCaseReference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "prosecution_case_id"
    t.uuid "defence_counsel_id"
    t.uuid "masterDefendantId"
    t.boolean "defendantDetailsUpdated", default: false, null: false
    t.uuid "company_representatives_id"
    t.index ["company_representatives_id"], name: "index_defendants_on_company_representatives_id"
    t.index ["defence_counsel_id"], name: "index_defendants_on_defence_counsel_id"
    t.index ["defendable_type", "defendable_id"], name: "index_defendants_on_defendable_type_and_defendable_id"
    t.index ["prosecution_case_id"], name: "index_defendants_on_prosecution_case_id"
  end

  create_table "delegated_powers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "userId"
    t.string "firstName"
    t.string "lastName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ethnicities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "observedEthnicityId"
    t.string "observedEthnicityCode"
    t.string "observedEthnicityDescription"
    t.uuid "selfDefinedEthnicityId"
    t.string "selfDefinedEthnicityCode"
    t.string "selfDefinedEthnicityDescription"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "future_summons_hearings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "jurisdiction_type"
    t.string "earliest_start_date_time"
    t.json "week_commencing_date"
    t.integer "estimated_minutes"
    t.uuid "court_centre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hearing_case_notes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "court_clerk_id", null: false
    t.datetime "noteDateTime", precision: nil
    t.string "noteType"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "hearing_id"
    t.index ["court_clerk_id"], name: "index_hearing_case_notes_on_court_clerk_id"
    t.index ["hearing_id"], name: "index_hearing_case_notes_on_hearing_id"
  end

  create_table "hearing_days", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "sittingDay", precision: nil
    t.integer "listingSequence"
    t.integer "listedDurationMinutes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "hearing_id"
    t.uuid "court_centre_id"
    t.boolean "isCancelled"
    t.uuid "courtRoomId"
    t.boolean "hasSharedResults"
    t.index ["court_centre_id"], name: "index_hearing_days_on_court_centre_id"
    t.index ["hearing_id"], name: "index_hearing_days_on_hearing_id"
  end

  create_table "hearing_events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "hearingEventDefinitionId"
    t.string "recordedLabel"
    t.datetime "eventTime", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "alterable", default: false, null: false
    t.uuid "hearing_day_id", null: false
    t.string "note"
    t.index ["hearing_day_id"], name: "index_hearing_events_on_hearing_day_id"
  end

  create_table "hearing_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "description"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hearings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "jurisdictionType"
    t.string "reportingRestrictionReason"
    t.uuid "court_centre_id", null: false
    t.string "hearingLanguage"
    t.boolean "hasSharedResults"
    t.uuid "hearing_type_id", null: false
    t.uuid "cracked_ineffective_trial_id"
    t.boolean "isEffectiveTrial"
    t.boolean "isBoxHearing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "resulted", default: false, null: false
    t.uuid "hearing_id"
    t.datetime "sitting_day", precision: nil
    t.index ["court_centre_id"], name: "index_hearings_on_court_centre_id"
    t.index ["cracked_ineffective_trial_id"], name: "index_hearings_on_cracked_ineffective_trial_id"
    t.index ["hearing_type_id"], name: "index_hearings_on_hearing_type_id"
  end

  create_table "indicated_pleas", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "indicatedPleaDate", precision: nil
    t.string "indicatedPleaValue"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "offence_id", null: false
    t.uuid "hearing_id", null: false
    t.index ["hearing_id"], name: "index_indicated_pleas_on_hearing_id"
    t.index ["offence_id"], name: "index_indicated_pleas_on_offence_id"
  end

  create_table "judicial_result_prompt_duration_elements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "primaryDurationUnit"
    t.integer "primaryDurationValue"
    t.string "primaryLabel"
    t.string "secondaryDurationUnit"
    t.integer "secondaryDurationValue"
    t.string "tertiaryDurationUnit"
    t.integer "tertiaryDurationValue"
    t.datetime "durationStartDate", precision: nil
    t.datetime "durationEndDate", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "judicial_result_prompts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "label"
    t.boolean "isAvailableForCourtExtract", null: false
    t.string "welshLabel"
    t.string "value"
    t.string "qualifier"
    t.integer "durationSequence"
    t.integer "promptSequence"
    t.string "promptReference"
    t.integer "totalPenaltyPoints"
    t.boolean "isFinancialImposition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "judicial_result_id"
    t.uuid "judicialResultPromptTypeId"
    t.string "welsh_value"
    t.index ["judicial_result_id"], name: "index_judicial_result_prompts_on_judicial_result_id"
  end

  create_table "judicial_results", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "judicialResultId"
    t.uuid "orderedHearingId"
    t.string "label"
    t.string "welshLabel"
    t.boolean "isAdjournmentResult", null: false
    t.boolean "isFinancialResult", null: false
    t.boolean "isConvictedResult", null: false
    t.boolean "isAvailableForCourtExtract", null: false
    t.boolean "isDeleted"
    t.uuid "amendmentReasonId"
    t.string "amendmentReason"
    t.datetime "amendmentDate", precision: nil
    t.string "qualifier"
    t.string "resultText"
    t.string "cjsCode"
    t.string "postHearingCustodyStatus"
    t.integer "rank"
    t.datetime "orderedDate", precision: nil
    t.string "lastSharedDateTime"
    t.boolean "terminatesOffenceProceedings", null: false
    t.uuid "court_clerk_id"
    t.uuid "delegated_powers_id"
    t.uuid "four_eyes_approval_id"
    t.datetime "approvedDate", precision: nil
    t.string "category"
    t.uuid "next_hearing_id"
    t.uuid "duration_element_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "offence_id"
    t.uuid "defendant_id"
    t.uuid "court_application_id"
    t.uuid "judicialResultTypeId"
    t.uuid "hearing_id", null: false
    t.index ["court_application_id"], name: "index_judicial_results_on_court_application_id"
    t.index ["court_clerk_id"], name: "index_judicial_results_on_court_clerk_id"
    t.index ["defendant_id"], name: "index_judicial_results_on_defendant_id"
    t.index ["delegated_powers_id"], name: "index_judicial_results_on_delegated_powers_id"
    t.index ["duration_element_id"], name: "index_judicial_results_on_duration_element_id"
    t.index ["four_eyes_approval_id"], name: "index_judicial_results_on_four_eyes_approval_id"
    t.index ["hearing_id"], name: "index_judicial_results_on_hearing_id"
    t.index ["next_hearing_id"], name: "index_judicial_results_on_next_hearing_id"
    t.index ["offence_id"], name: "index_judicial_results_on_offence_id"
  end

  create_table "judicial_role_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "judicialRoleTypeId"
    t.string "judiciaryType"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "judicial_roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "judicialId"
    t.string "title"
    t.string "firstName"
    t.string "middleName"
    t.string "lastName"
    t.uuid "judicial_role_type_id", null: false
    t.boolean "isDeputy"
    t.boolean "isBenchChairman"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "next_hearing_id"
    t.uuid "hearing_id"
    t.uuid "hearing_day_id"
    t.bigint "court_hearing_request_id"
    t.bigint "future_summons_hearing_id"
    t.index ["court_hearing_request_id"], name: "index_judicial_roles_on_court_hearing_request_id"
    t.index ["future_summons_hearing_id"], name: "index_judicial_roles_on_future_summons_hearing_id"
    t.index ["hearing_day_id"], name: "index_judicial_roles_on_hearing_day_id"
    t.index ["hearing_id"], name: "index_judicial_roles_on_hearing_id"
    t.index ["judicial_role_type_id"], name: "index_judicial_roles_on_judicial_role_type_id"
    t.index ["next_hearing_id"], name: "index_judicial_roles_on_next_hearing_id"
  end

  create_table "jurors", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "numberOfJurors"
    t.integer "numberOfSplitJurors"
    t.boolean "unanimous"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "laa_references", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "applicationReference"
    t.uuid "statusId"
    t.string "statusCode"
    t.string "statusDescription"
    t.datetime "statusDate", precision: nil
    t.datetime "effectiveStartDate", precision: nil
    t.datetime "effectiveEndDate", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "offence_id"
    t.string "offenceLevelStatus"
    t.index ["offence_id"], name: "index_laa_references_on_offence_id"
  end

  create_table "legal_entity_defendants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "organisation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organisation_id"], name: "index_legal_entity_defendants_on_organisation_id"
  end

  create_table "lesser_or_alternative_offences", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "offenceDefinitionId"
    t.string "offenceCode"
    t.string "offenceTitle"
    t.string "offenceTitleWelsh"
    t.string "offenceLegislation"
    t.string "offenceLegislationWelsh"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "linked_defendants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "prosecutionCaseId"
    t.uuid "defendantId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "defendant_id"
    t.index ["defendant_id"], name: "index_linked_defendants_on_defendant_id"
  end

  create_table "linked_prosecution_cases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "prosecution_case_id"
    t.index ["prosecution_case_id"], name: "index_linked_prosecution_cases_on_prosecution_case_id"
  end

  create_table "lja_details", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "lja_code"
    t.string "lja_name"
    t.string "welsh_lja_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "markers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "markerTypeid"
    t.string "sequenceNumber"
    t.string "markerTypeCode"
    t.string "markerTypeLabel"
    t.string "markerTypeName"
    t.string "splitProsecutorCaseReference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "defendant_id"
    t.uuid "prosecution_case_id"
    t.index ["defendant_id"], name: "index_markers_on_defendant_id"
    t.index ["prosecution_case_id"], name: "index_markers_on_prosecution_case_id"
  end

  create_table "master_defendants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "master_defendant_id"
    t.uuid "person_defendant_id", null: false
    t.boolean "is_youth"
    t.string "pnc_id"
    t.string "prosecution_authority_reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_defendant_id"], name: "index_master_defendants_on_person_defendant_id"
  end

  create_table "merged_prosecution_case_targets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "prosecutionCaseId"
    t.string "prosecutionCaseReference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "merged_prosecution_case_id"
    t.index ["merged_prosecution_case_id"], name: "index_merged_prosecution_case_targets_on_case_id"
  end

  create_table "merged_prosecution_cases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "prosecutionCaseReference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "next_hearing_court_applications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "next_hearing_id"
    t.index ["next_hearing_id"], name: "index_next_hearing_court_applications_on_next_hearing_id"
  end

  create_table "next_hearing_defendants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "next_hearing_prosecution_case_id"
    t.index ["next_hearing_prosecution_case_id"], name: "index_next_hearing_defendants_on_prosecution_case_id"
  end

  create_table "next_hearing_offences", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "next_hearing_defendant_id"
    t.index ["next_hearing_defendant_id"], name: "index_next_hearing_offences_on_next_hearing_defendant_id"
  end

  create_table "next_hearing_prosecution_cases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "next_hearing_id"
    t.index ["next_hearing_id"], name: "index_next_hearing_prosecution_cases_on_next_hearing_id"
  end

  create_table "next_hearings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "hearing_type_id", null: false
    t.string "jurisdictionType"
    t.string "reportingRestrictionReason"
    t.string "adjournmentReason"
    t.string "hearingLanguage"
    t.datetime "listedStartDateTime", precision: nil
    t.integer "estimatedMinutes"
    t.uuid "court_centre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["court_centre_id"], name: "index_next_hearings_on_court_centre_id"
    t.index ["hearing_type_id"], name: "index_next_hearings_on_hearing_type_id"
  end

  create_table "notified_pleas", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "notifiedPleaDate", precision: nil
    t.string "notifiedPleaValue"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "offence_id", null: false
    t.index ["offence_id"], name: "index_notified_pleas_on_offence_id"
  end

  create_table "offence_facts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "vehicleRegistration"
    t.integer "alcoholReadingAmount"
    t.string "alcoholReadingMethodCode"
    t.string "alcoholReadingMethodDescription"
    t.string "vehicleCode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offences", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "offenceDefinitionId"
    t.string "offenceCode"
    t.string "offenceTitle"
    t.string "offenceTitleWelsh"
    t.string "offenceLegislation"
    t.string "offenceLegislationWelsh"
    t.string "modeOfTrial"
    t.string "wording"
    t.string "wordingWelsh"
    t.datetime "startDate", precision: nil
    t.datetime "endDate", precision: nil
    t.datetime "arrestDate", precision: nil
    t.datetime "chargeDate", precision: nil
    t.datetime "dateOfInformation", precision: nil
    t.integer "orderIndex"
    t.integer "count"
    t.datetime "convictionDate", precision: nil
    t.uuid "offence_facts_id"
    t.datetime "aquittalDate", precision: nil
    t.boolean "isDisposed"
    t.boolean "isDiscontinued"
    t.boolean "isIntroduceAfterInitialProceedings"
    t.uuid "custody_time_limit_id"
    t.string "splitProsecutorCaseReference"
    t.string "mergedProsecutionCaseReference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "defendant_id"
    t.string "dvlaCode"
    t.datetime "laidDate", precision: nil
    t.boolean "proceedingsConcluded", default: false, null: false
    t.boolean "pendingCBPW", default: false, null: false
    t.boolean "civilOffence", default: false, null: false
    t.bigint "court_application_case_id"
    t.string "dvla_offence_code"
    t.bigint "committing_court_id"
    t.integer "offence_date_code"
    t.index ["committing_court_id"], name: "index_offences_on_committing_court_id"
    t.index ["court_application_case_id"], name: "index_offences_on_court_application_case_id"
    t.index ["custody_time_limit_id"], name: "index_offences_on_custody_time_limit_id"
    t.index ["defendant_id"], name: "index_offences_on_defendant_id"
    t.index ["offence_facts_id"], name: "index_offences_on_offence_facts_id"
  end

  create_table "organisations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "incorporationNumber"
    t.string "registeredCharityNumber"
    t.uuid "address_id"
    t.uuid "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_organisations_on_address_id"
    t.index ["contact_id"], name: "index_organisations_on_contact_id"
  end

  create_table "people", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.string "firstName"
    t.string "middleName"
    t.string "lastName"
    t.datetime "dateOfBirth", precision: nil
    t.uuid "nationalityId"
    t.string "nationalityCode"
    t.string "nationalityDescription"
    t.uuid "additionalNationalityId"
    t.string "additionalNationalityCode"
    t.string "additionalNationalityDescription"
    t.string "disabilityStatus"
    t.uuid "ethnicity_id"
    t.string "gender"
    t.string "interpreterLanguageNeeds"
    t.string "documentationLanguageNeeds"
    t.string "nationalInsuranceNumber"
    t.string "occupation"
    t.string "occupationCode"
    t.string "specificRequirements"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "address_id"
    t.uuid "contact_number_id"
    t.uuid "offence_id"
    t.index ["address_id"], name: "index_people_on_address_id"
    t.index ["contact_number_id"], name: "index_people_on_contact_number_id"
    t.index ["ethnicity_id"], name: "index_people_on_ethnicity_id"
    t.index ["offence_id"], name: "index_people_on_offence_id"
  end

  create_table "person_defendants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "person_id", null: false
    t.uuid "bail_status_id"
    t.string "bailConditions"
    t.string "bailReasons"
    t.datetime "custodyTimeLimit", precision: nil
    t.integer "perceivedBirthYear"
    t.string "driverNumber"
    t.string "driverLicenceCode"
    t.string "driverLicenseIssue"
    t.string "vehicleOperatorLicenceNumber"
    t.string "arrestSummonsNumber"
    t.uuid "employer_organisation_id"
    t.string "employerPayrollReference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "defendant_custody_location_id"
    t.index ["bail_status_id"], name: "index_person_defendants_on_bail_status_id"
    t.index ["defendant_custody_location_id"], name: "index_person_defendants_on_defendant_custody_location_id"
    t.index ["employer_organisation_id"], name: "index_person_defendants_on_employer_organisation_id"
    t.index ["person_id"], name: "index_person_defendants_on_person_id"
  end

  create_table "plea_models", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "prosecution_case_id"
    t.uuid "defendant_id"
    t.uuid "offence_id"
    t.uuid "indicated_plea_id", null: false
    t.uuid "plea_id", null: false
    t.uuid "allocation_decision_id", null: false
    t.uuid "application_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["allocation_decision_id"], name: "index_plea_models_on_allocation_decision_id"
    t.index ["indicated_plea_id"], name: "index_plea_models_on_indicated_plea_id"
    t.index ["plea_id"], name: "index_plea_models_on_plea_id"
  end

  create_table "pleas", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "pleaDate", precision: nil
    t.string "pleaValue"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "delegated_powers_id"
    t.uuid "offence_id", null: false
    t.uuid "hearing_id", null: false
    t.uuid "application_id"
    t.bigint "lesser_or_alternative_offence_id"
    t.index ["delegated_powers_id"], name: "index_pleas_on_delegated_powers_id"
    t.index ["hearing_id"], name: "index_pleas_on_hearing_id"
    t.index ["lesser_or_alternative_offence_id"], name: "index_pleas_on_lesser_or_alternative_offence_id"
    t.index ["offence_id"], name: "index_pleas_on_offence_id"
  end

  create_table "police_officer_in_cases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "person_id", null: false
    t.string "policeOfficerRank"
    t.string "policeWorkerReferenceNumber"
    t.string "policeWorkerLocationCode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_police_officer_in_cases_on_person_id"
  end

  create_table "prosecuting_authorities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "prosecutionAuthorityId"
    t.string "prosecutionAuthorityCode"
    t.string "name"
    t.string "accountCode"
    t.uuid "address_id"
    t.uuid "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_prosecuting_authorities_on_address_id"
    t.index ["contact_id"], name: "index_prosecuting_authorities_on_contact_id"
  end

  create_table "prosecution_case_hearing_case_notes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "prosecution_case_id", null: false
    t.uuid "hearing_case_note_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hearing_case_note_id"], name: "prosecution_case_hearing_case_notes_on_hearing_case_note_id"
    t.index ["prosecution_case_id"], name: "prosecution_case_hearing_case_notes_on_prosecution_case_id"
  end

  create_table "prosecution_case_hearings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "prosecution_case_id", null: false
    t.uuid "hearing_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hearing_id"], name: "index_prosecution_case_hearings_on_hearing_id"
    t.index ["prosecution_case_id"], name: "index_prosecution_case_hearings_on_prosecution_case_id"
  end

  create_table "prosecution_case_identifiers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "caseURN"
    t.string "prosecutionAuthorityReference"
    t.uuid "prosecutionAuthorityId", null: false
    t.string "prosecutionAuthorityCode", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "prosecution_authority_name"
    t.string "prosecution_authority_oucode"
    t.string "major_creditor_code"
    t.uuid "address_id"
    t.uuid "contact_number_id"
    t.index ["address_id"], name: "index_prosecution_case_identifiers_on_address_id"
    t.index ["contact_number_id"], name: "index_prosecution_case_identifiers_on_contact_number_id"
  end

  create_table "prosecution_cases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "prosecution_case_identifier_id", null: false
    t.string "originatingOrganisation"
    t.string "initiationCode"
    t.string "caseStatus"
    t.uuid "police_officer_in_case_id"
    t.string "statementOfFacts"
    t.string "statementOfFactsWelsh"
    t.boolean "breachProceedingsPending"
    t.boolean "appealProceedingsPending"
    t.uuid "merged_prosecution_case_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "prosecution_counsel_id"
    t.string "removalReason"
    t.string "class_of_case"
    t.boolean "is_cps_org_verify_error"
    t.string "summons_code"
    t.boolean "concluded"
    t.index ["merged_prosecution_case_id"], name: "index_prosecution_cases_on_merged_prosecution_case_id"
    t.index ["police_officer_in_case_id"], name: "index_prosecution_cases_on_police_officer_in_case_id"
    t.index ["prosecution_case_identifier_id"], name: "index_prosecution_cases_on_prosecution_case_identifier_id"
    t.index ["prosecution_counsel_id"], name: "index_prosecution_cases_on_prosecution_counsel_id"
  end

  create_table "prosecution_counsels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.string "firstName"
    t.string "middleName"
    t.string "lastName"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "hearing_id"
    t.index ["hearing_id"], name: "index_prosecution_counsels_on_hearing_id"
  end

  create_table "referral_reasons", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "description"
    t.uuid "defendantId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "hearing_id"
    t.index ["hearing_id"], name: "index_referral_reasons_on_hearing_id"
  end

  create_table "reporting_restrictions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "judicial_result_id"
    t.string "label"
    t.string "ordered_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "offence_id"
    t.index ["offence_id"], name: "index_reporting_restrictions_on_offence_id"
  end

  create_table "respondent_counsels", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.string "firstName"
    t.string "middleName"
    t.string "lastName"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "hearing_id"
    t.uuid "respondents", default: [], array: true
    t.index ["hearing_id"], name: "index_respondent_counsels_on_hearing_id"
  end

  create_table "rota_slots", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "start_time"
    t.integer "duration"
    t.string "court_schedule_id"
    t.string "session"
    t.string "oucode"
    t.integer "court_room_id"
    t.string "court_centre_id"
    t.string "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "court_hearing_request_id"
    t.index ["court_hearing_request_id"], name: "index_rota_slots_on_court_hearing_request_id"
  end

  create_table "seeding_hearings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "seeding_hearing_id"
    t.string "jurisdiction_type"
    t.string "sitting_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "split_prosecutor_case_references", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "split"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "defendant_id"
    t.uuid "prosecution_case_id"
    t.index ["defendant_id"], name: "index_split_prosecutor_case_references_on_defendant_id"
    t.index ["prosecution_case_id"], name: "index_split_prosecutor_case_references_on_prosecution_case_id"
  end

  create_table "user_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "judicial_result_prompt_id"
    t.uuid "judicial_result_id"
    t.index ["judicial_result_id"], name: "index_user_groups_on_judicial_result_id"
    t.index ["judicial_result_prompt_id"], name: "index_user_groups_on_judicial_result_prompt_id"
  end

  create_table "verdict_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "sequence"
    t.string "description"
    t.string "category"
    t.string "categoryType"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cjs_verdict_code"
    t.string "verdict_code"
  end

  create_table "verdicts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "verdictDate", precision: nil
    t.uuid "verdict_type_id", null: false
    t.uuid "jurors_id"
    t.uuid "lesser_or_alternative_offence_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "offence_id", null: false
    t.uuid "hearing_id", null: false
    t.uuid "application_id"
    t.index ["hearing_id"], name: "index_verdicts_on_hearing_id"
    t.index ["jurors_id"], name: "index_verdicts_on_jurors_id"
    t.index ["lesser_or_alternative_offence_id"], name: "index_verdicts_on_lesser_or_alternative_offence_id"
    t.index ["offence_id"], name: "index_verdicts_on_offence_id"
    t.index ["verdict_type_id"], name: "index_verdicts_on_verdict_type_id"
  end

  add_foreign_key "allocation_decisions", "court_indicated_sentences"
  add_foreign_key "allocation_decisions", "hearings"
  add_foreign_key "allocation_decisions", "offences"
  add_foreign_key "applicant_counsels", "hearings"
  add_foreign_key "applicants", "applicant_counsels"
  add_foreign_key "application_pleas", "delegated_powers", column: "delegated_powers_id"
  add_foreign_key "application_pleas", "lesser_or_alternative_offences"
  add_foreign_key "application_verdicts", "jurors", column: "jurors_id"
  add_foreign_key "application_verdicts", "lesser_or_alternative_offences"
  add_foreign_key "application_verdicts", "verdict_types"
  add_foreign_key "associated_people", "court_application_parties"
  add_foreign_key "associated_people", "defendants"
  add_foreign_key "associated_people", "people"
  add_foreign_key "attendance_days", "applicant_counsels"
  add_foreign_key "attendance_days", "court_application_party_attendances"
  add_foreign_key "attendance_days", "court_application_party_counsels"
  add_foreign_key "attendance_days", "defence_counsels"
  add_foreign_key "attendance_days", "defendant_attendances"
  add_foreign_key "attendance_days", "prosecution_counsels"
  add_foreign_key "attendance_days", "respondent_counsels"
  add_foreign_key "bail_statuses", "custody_time_limits"
  add_foreign_key "court_application_cases", "court_applications"
  add_foreign_key "court_application_cases", "prosecution_case_identifiers"
  add_foreign_key "court_application_hearings", "court_applications"
  add_foreign_key "court_application_hearings", "hearings"
  add_foreign_key "court_application_parties", "court_application_party_counsels"
  add_foreign_key "court_application_parties", "court_applications"
  add_foreign_key "court_application_parties", "master_defendants"
  add_foreign_key "court_application_parties", "organisations"
  add_foreign_key "court_application_parties", "organisations", column: "representation_organisation_id"
  add_foreign_key "court_application_parties", "people"
  add_foreign_key "court_application_parties", "prosecuting_authorities"
  add_foreign_key "court_application_party_attendances", "court_application_parties"
  add_foreign_key "court_application_party_attendances", "hearings"
  add_foreign_key "court_application_party_counsels", "hearings"
  add_foreign_key "court_application_prosecution_cases", "court_applications"
  add_foreign_key "court_application_prosecution_cases", "prosecution_cases"
  add_foreign_key "court_applications", "court_application_outcomes"
  add_foreign_key "court_applications", "court_application_parties"
  add_foreign_key "court_applications", "court_application_payments"
  add_foreign_key "court_applications", "court_application_types"
  add_foreign_key "court_applications", "hearings"
  add_foreign_key "court_hearing_requests", "hearing_types"
  add_foreign_key "court_order_offences", "offences"
  add_foreign_key "court_order_offences", "prosecution_case_identifiers"
  add_foreign_key "defence_counsels", "hearings"
  add_foreign_key "defence_organisations", "defendants"
  add_foreign_key "defence_organisations", "organisations"
  add_foreign_key "defendant_aliases", "defendants"
  add_foreign_key "defendant_attendances", "defendants"
  add_foreign_key "defendant_attendances", "hearings"
  add_foreign_key "defendant_hearing_youth_markers", "defendants"
  add_foreign_key "defendant_hearing_youth_markers", "hearings"
  add_foreign_key "defendant_hearing_youth_markers", "markers"
  add_foreign_key "defendant_hearing_youth_markers", "prosecution_cases"
  add_foreign_key "defendant_judicial_results", "judicial_results"
  add_foreign_key "defendants", "defence_counsels"
  add_foreign_key "defendants", "prosecution_cases"
  add_foreign_key "hearing_case_notes", "delegated_powers", column: "court_clerk_id"
  add_foreign_key "hearing_case_notes", "hearings"
  add_foreign_key "hearing_days", "hearings"
  add_foreign_key "hearing_events", "hearing_days"
  add_foreign_key "hearings", "cracked_ineffective_trials"
  add_foreign_key "hearings", "hearing_types"
  add_foreign_key "indicated_pleas", "hearings"
  add_foreign_key "indicated_pleas", "offences"
  add_foreign_key "judicial_result_prompts", "judicial_results"
  add_foreign_key "judicial_results", "court_applications"
  add_foreign_key "judicial_results", "defendants"
  add_foreign_key "judicial_results", "delegated_powers", column: "court_clerk_id"
  add_foreign_key "judicial_results", "delegated_powers", column: "delegated_powers_id"
  add_foreign_key "judicial_results", "delegated_powers", column: "four_eyes_approval_id"
  add_foreign_key "judicial_results", "hearings"
  add_foreign_key "judicial_results", "judicial_result_prompt_duration_elements", column: "duration_element_id"
  add_foreign_key "judicial_results", "next_hearings"
  add_foreign_key "judicial_results", "offences"
  add_foreign_key "judicial_roles", "hearing_days"
  add_foreign_key "judicial_roles", "hearings"
  add_foreign_key "judicial_roles", "judicial_role_types"
  add_foreign_key "judicial_roles", "next_hearings"
  add_foreign_key "laa_references", "offences"
  add_foreign_key "legal_entity_defendants", "organisations"
  add_foreign_key "linked_defendants", "defendants"
  add_foreign_key "linked_prosecution_cases", "prosecution_cases"
  add_foreign_key "markers", "defendants"
  add_foreign_key "markers", "prosecution_cases"
  add_foreign_key "master_defendants", "person_defendants"
  add_foreign_key "merged_prosecution_case_targets", "merged_prosecution_cases"
  add_foreign_key "next_hearing_court_applications", "next_hearings"
  add_foreign_key "next_hearing_defendants", "next_hearing_prosecution_cases"
  add_foreign_key "next_hearing_offences", "next_hearing_defendants"
  add_foreign_key "next_hearing_prosecution_cases", "next_hearings"
  add_foreign_key "next_hearings", "hearing_types"
  add_foreign_key "notified_pleas", "offences"
  add_foreign_key "offences", "custody_time_limits"
  add_foreign_key "offences", "defendants"
  add_foreign_key "offences", "offence_facts", column: "offence_facts_id"
  add_foreign_key "organisations", "addresses"
  add_foreign_key "organisations", "contact_numbers", column: "contact_id"
  add_foreign_key "people", "addresses"
  add_foreign_key "people", "contact_numbers"
  add_foreign_key "people", "ethnicities"
  add_foreign_key "people", "offences"
  add_foreign_key "person_defendants", "bail_statuses"
  add_foreign_key "person_defendants", "organisations", column: "employer_organisation_id"
  add_foreign_key "person_defendants", "people"
  add_foreign_key "plea_models", "allocation_decisions"
  add_foreign_key "plea_models", "indicated_pleas"
  add_foreign_key "plea_models", "pleas"
  add_foreign_key "pleas", "delegated_powers", column: "delegated_powers_id"
  add_foreign_key "pleas", "hearings"
  add_foreign_key "pleas", "offences"
  add_foreign_key "police_officer_in_cases", "people"
  add_foreign_key "prosecuting_authorities", "addresses"
  add_foreign_key "prosecuting_authorities", "contact_numbers", column: "contact_id"
  add_foreign_key "prosecution_case_hearing_case_notes", "hearing_case_notes"
  add_foreign_key "prosecution_case_hearing_case_notes", "prosecution_cases"
  add_foreign_key "prosecution_case_hearings", "hearings"
  add_foreign_key "prosecution_case_hearings", "prosecution_cases"
  add_foreign_key "prosecution_case_identifiers", "addresses"
  add_foreign_key "prosecution_case_identifiers", "contact_numbers"
  add_foreign_key "prosecution_cases", "merged_prosecution_cases"
  add_foreign_key "prosecution_cases", "police_officer_in_cases"
  add_foreign_key "prosecution_cases", "prosecution_case_identifiers"
  add_foreign_key "prosecution_cases", "prosecution_counsels"
  add_foreign_key "prosecution_counsels", "hearings"
  add_foreign_key "referral_reasons", "hearings"
  add_foreign_key "respondent_counsels", "hearings"
  add_foreign_key "split_prosecutor_case_references", "defendants"
  add_foreign_key "split_prosecutor_case_references", "prosecution_cases"
  add_foreign_key "user_groups", "judicial_result_prompts"
  add_foreign_key "user_groups", "judicial_results"
  add_foreign_key "verdicts", "hearings"
  add_foreign_key "verdicts", "jurors", column: "jurors_id"
  add_foreign_key "verdicts", "lesser_or_alternative_offences"
  add_foreign_key "verdicts", "offences"
  add_foreign_key "verdicts", "verdict_types"
end
