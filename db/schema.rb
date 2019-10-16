# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_10_16_084141) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "address1", null: false
    t.string "address2"
    t.string "address3"
    t.string "address4"
    t.string "address5"
    t.string "postcode"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "allocation_decisions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "originatingHearingId"
    t.uuid "offenceId"
    t.uuid "motReasonId"
    t.string "motReasonDescription"
    t.integer "motReasonCode"
    t.datetime "allocationDecisionDate"
    t.boolean "isSection22ALowValueShoplifting", default: false, null: false
    t.boolean "isDamageValueUnder5000", default: false, null: false
    t.boolean "isTreatedAsIndictableOnly", default: false, null: false
    t.boolean "sentencingIndicationRequested", default: false, null: false
    t.uuid "court_indicated_sentence_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["court_indicated_sentence_id"], name: "index_allocation_decisions_on_court_indicated_sentence_id"
  end

  create_table "contact_numbers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "home"
    t.string "work"
    t.string "mobile"
    t.string "primaryEmail"
    t.string "secondaryEmail"
    t.string "fax"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "court_centres", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "welshName"
    t.uuid "roomId"
    t.string "roomName"
    t.string "welshRoomName"
    t.uuid "address_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_id"], name: "index_court_centres_on_address_id"
  end

  create_table "court_indicated_sentences", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "courtIndicatedSentenceTypeId"
    t.string "courtIndicatedSentenceDescription"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "delegated_powers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "userId"
    t.string "firstName"
    t.string "lastName"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ethnicities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "observedEthnicityId"
    t.string "observedEthnicityCode"
    t.string "observedEthnicityDescription"
    t.uuid "selfDefinedEthnicityId"
    t.string "selfDefinedEthnicityCode"
    t.string "selfDefinedEthnicityDescription"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hearing_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "description"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "indicated_pleas", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "offenceId"
    t.uuid "originatingHearingId"
    t.datetime "indicatedPleaDate"
    t.string "indicatedPleaValue"
    t.string "source"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "judicial_result_prompt_duration_elements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "primaryDurationUnit"
    t.integer "primaryDurationValue"
    t.string "primaryLabel"
    t.string "secondaryDurationUnit"
    t.integer "secondaryDurationValue"
    t.string "tertiaryDurationUnit"
    t.string "tertiaryDurationValue"
    t.datetime "durationStartDate"
    t.datetime "durationEndDate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "judicial_role_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "judicialRoleTypeId"
    t.string "judiciaryType"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "next_hearing_id"
    t.index ["judicial_role_type_id"], name: "index_judicial_roles_on_judicial_role_type_id"
    t.index ["next_hearing_id"], name: "index_judicial_roles_on_next_hearing_id"
  end

  create_table "jurors", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "numberOfJurors"
    t.integer "numberOfSplitJurors"
    t.boolean "unanimous"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lesser_or_alternative_offences", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "offenceDefinitionId"
    t.string "offenceCode"
    t.string "offenceTitle"
    t.string "offenceTitleWelsh"
    t.string "offenceLegislation"
    t.string "offenceLegislationWelsh"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "next_hearing_court_applications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "next_hearing_id"
    t.index ["next_hearing_id"], name: "index_next_hearing_court_applications_on_next_hearing_id"
  end

  create_table "next_hearing_defendants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "next_hearing_prosecution_case_id"
    t.index ["next_hearing_prosecution_case_id"], name: "index_next_hearing_defendants_on_prosecution_case_id"
  end

  create_table "next_hearing_offences", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "next_hearing_defendant_id"
    t.index ["next_hearing_defendant_id"], name: "index_next_hearing_offences_on_next_hearing_defendant_id"
  end

  create_table "next_hearing_prosecution_cases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "next_hearing_id"
    t.index ["next_hearing_id"], name: "index_next_hearing_prosecution_cases_on_next_hearing_id"
  end

  create_table "next_hearings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "hearing_type_id", null: false
    t.string "jurisdictionType"
    t.string "reportingRestrictionReason"
    t.string "adjournmentReason"
    t.string "hearingLanguage"
    t.datetime "listedStartDateTime"
    t.integer "estimatedMinutes"
    t.uuid "court_centre_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["court_centre_id"], name: "index_next_hearings_on_court_centre_id"
    t.index ["hearing_type_id"], name: "index_next_hearings_on_hearing_type_id"
  end

  create_table "notified_pleas", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "offenceId"
    t.datetime "notifiedPleaDate"
    t.string "notifiedPleaValue"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "offence_facts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "vehicleRegistration"
    t.integer "alcoholReadingAmount"
    t.string "alcoholReadingMethodCode"
    t.string "alcoholReadingMethodDescription"
    t.string "vehicleCode"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "people", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.string "firstName"
    t.string "middleName"
    t.string "lastName"
    t.datetime "dateOfBirth"
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "address_id"
    t.uuid "contact_number_id"
    t.index ["address_id"], name: "index_people_on_address_id"
    t.index ["contact_number_id"], name: "index_people_on_contact_number_id"
    t.index ["ethnicity_id"], name: "index_people_on_ethnicity_id"
  end

  create_table "pleas", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "originatingHearingId"
    t.uuid "offenceId"
    t.datetime "pleaDate"
    t.string "pleaValue"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "delegated_powers_id"
    t.index ["delegated_powers_id"], name: "index_pleas_on_delegated_powers_id"
  end

  create_table "police_officer_in_cases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "person_id", null: false
    t.string "policeOfficerRank"
    t.string "policeWorkerReferenceNumber"
    t.string "policeWorkerLocationCode"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_police_officer_in_cases_on_person_id"
  end

  create_table "prosecution_case_identifiers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "caseURN"
    t.string "prosecutionAuthorityReference"
    t.uuid "prosecutionAuthorityId", null: false
    t.string "prosecutionAuthorityCode", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "group"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "judicial_result_prompt_id"
    t.index ["judicial_result_prompt_id"], name: "index_user_groups_on_judicial_result_prompt_id"
  end

  create_table "verdict_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "sequence"
    t.string "description"
    t.string "category"
    t.string "categoryType"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "verdicts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "originatingHearingId"
    t.uuid "offenceId"
    t.datetime "verdictDate"
    t.uuid "verdict_type_id", null: false
    t.uuid "jurors_id"
    t.uuid "lesser_or_alternative_offence_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["jurors_id"], name: "index_verdicts_on_jurors_id"
    t.index ["lesser_or_alternative_offence_id"], name: "index_verdicts_on_lesser_or_alternative_offence_id"
    t.index ["verdict_type_id"], name: "index_verdicts_on_verdict_type_id"
  end

  add_foreign_key "allocation_decisions", "court_indicated_sentences"
  add_foreign_key "court_centres", "addresses"
  add_foreign_key "judicial_roles", "judicial_role_types"
  add_foreign_key "judicial_roles", "next_hearings"
  add_foreign_key "next_hearing_court_applications", "next_hearings"
  add_foreign_key "next_hearing_defendants", "next_hearing_prosecution_cases"
  add_foreign_key "next_hearing_offences", "next_hearing_defendants"
  add_foreign_key "next_hearing_prosecution_cases", "next_hearings"
  add_foreign_key "next_hearings", "court_centres"
  add_foreign_key "next_hearings", "hearing_types"
  add_foreign_key "people", "addresses"
  add_foreign_key "people", "contact_numbers"
  add_foreign_key "people", "ethnicities"
  add_foreign_key "pleas", "delegated_powers", column: "delegated_powers_id"
  add_foreign_key "police_officer_in_cases", "people"
  add_foreign_key "user_groups", "judicial_result_prompts"
  add_foreign_key "verdicts", "jurors", column: "jurors_id"
  add_foreign_key "verdicts", "lesser_or_alternative_offences"
  add_foreign_key "verdicts", "verdict_types"
end
