FactoryBot.define do
  factory :merged_prosecution_case do
    prosecutionCaseReference { 'Random string' }
    after(:build) do |merged_prosecution_case|
      merged_prosecution_case.merged_prosecution_case_targets << FactoryBot.build_list(:merged_prosecution_case_target, 2)
    end
  end
end
