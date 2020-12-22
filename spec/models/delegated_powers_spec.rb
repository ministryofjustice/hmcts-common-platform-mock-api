# frozen_string_literal: true

RSpec.describe DelegatedPowers, type: :model do
  subject { delegated_powers }

  let(:delegated_powers) { FactoryBot.create(:delegated_powers) }

  let(:json_schema) { :delegated_powers }


  it { is_expected.to validate_presence_of(:userId) }
  it { is_expected.to validate_presence_of(:firstName) }
  it { is_expected.to validate_presence_of(:lastName) }

  it_has_behaviour "conforming to valid schema"
end
