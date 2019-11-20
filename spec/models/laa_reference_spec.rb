# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LaaReference, type: :model do
  let(:laa_reference) { FactoryBot.create(:laa_reference) }

  let(:json_schema) { :laa_reference }

  subject { laa_reference }

  describe 'associations' do
    it { should belong_to(:offence).class_name('Offence').optional }
  end
  describe 'validations' do
    it { should validate_presence_of(:applicationReference) }
    it { should validate_presence_of(:statusId) }
    it { should validate_presence_of(:statusCode) }
    it { should validate_presence_of(:statusDescription) }
    it { should validate_presence_of(:statusDate) }
  end

  it_has_behaviour 'conforming to valid schema'

  describe '#to_builder' do
    context 'when all the dates are present' do
      it 'returns a JBuilder object' do
        expect(subject.to_builder).to be_an_instance_of(Jbuilder)
      end
    end

    context 'when there are missing dates' do
      let(:laa_reference) do
        FactoryBot.create(:laa_reference,
                          effectiveStartDate: nil,
                          effectiveEndDate: nil)
      end

      it 'returns a JBuilder object' do
        expect(subject.to_builder).to be_an_instance_of(Jbuilder)
      end

      it_has_behaviour 'conforming to valid schema'
    end
  end
end
