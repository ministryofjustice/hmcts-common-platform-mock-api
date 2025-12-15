# frozen_string_literal: true

FactoryBot.define do
  factory :court_application_type do
    id { SecureRandom.uuid }
    code { "MC80801" }
    legislation { "string" }
    valid_from { "2021-04-01" }
    valid_to { "2021-04-30" }
    listing_notif_template { "String" }
    boxwork_notif_template { "String" }
    type_welsh { "String" }
    legislation_welsh { "String" }
    hearing_code { "String" }
    resentencing_activation_code { "String" }
    prefix { "String" }
    linkType { "LINKED" }
    type { "String" }
    category_code { "String" }
    appeal_flag { true }
    jurisdiction { "MAGISTRATES" }
    summons_template_type { "GENERIC_APPLICATION" }
    breach_type { "GENERIC_BREACH" }
    applicant_appellant_flag { true }
    plea_applicable_flag { true }
    commr_of_oath_flag { true }
    court_of_appeal_flag { true }
    court_extract_avl_flag { true }
    prosecutor_third_party_flag { true }
    spi_out_applicable_flag { true }
    offence_active_order { "OFFENCE" }
  end

  trait :with_appeal_flag do
    appeal_flag { true }
    applicant_appellant_flag { true }
  end
end
