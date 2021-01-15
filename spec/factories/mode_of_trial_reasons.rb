FactoryBot.define do
  factory :mode_of_trial_reason do
    seq_number { 1 }
    reason_code { 1 }
    reason_description { "MyString" }
  end
end
