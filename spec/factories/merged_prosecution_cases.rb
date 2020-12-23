# frozen_string_literal: true

FactoryBot.define do
  factory :merged_prosecution_case do
    prosecutionCaseReference { "Random string" }
    after(:build) do |merged_prosecution_case|
      merged_prosecution_case.merged_prosecution_case_targets << build_list(:merged_prosecution_case_target, 2)
    end

    factory :realistic_merged_prosecution_case do
      prosecutionCaseReference { Faker::Lorem.word }
      after(:build) do |merged_prosecution_case|
        merged_prosecution_case.merged_prosecution_case_targets << build_list(:realistic_merged_prosecution_case_target, 2)
      end
    end
  end
end
