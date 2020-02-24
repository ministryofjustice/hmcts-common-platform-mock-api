# frozen_string_literal: true

FactoryBot.define do
  factory :legal_entity_defendant do
    organisation
    factory :realistic_legal_entity_defendant do
      association :organisation, factory: :realistic_organisation
    end
  end
end
