# frozen_string_literal: true

FactoryBot.define do
  factory :ethnicity do
    observedEthnicityId { '785ed93c-afbd-45a5-9dbb-e7d0e2206fcf' }
    observedEthnicityCode { 'M3' }
    observedEthnicityDescription { 'White and Asian' }
    selfDefinedEthnicityId { '34bb463d-2937-4daf-8eac-ec28ba486dc7' }
    selfDefinedEthnicityCode { 'A2' }
    selfDefinedEthnicityDescription { 'British' }
  end
end
