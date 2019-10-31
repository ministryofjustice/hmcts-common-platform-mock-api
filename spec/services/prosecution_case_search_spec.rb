# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.describe ProsecutionCaseSearch do
  let(:params) { ActionController::Parameters.new(params_hash) }

  subject { described_class.call(params) }

  context 'with invalid params' do
    let(:params_hash) do
      { random: 'value' }
    end

    it 'raises an invalid params error' do
      expect do
        subject
      end.to raise_error(Errors::InvalidParams)
    end
  end

  context 'when searching by prosecutionCaseReference' do
    let(:cases) { FactoryBot.build_list(:prosecution_case, 3) }

    before do
      cases.first.prosecution_case_identifier = FactoryBot.build(:prosecution_case_identifier,
                                                                 caseURN: 'XXYYZZ')
      cases.second.prosecution_case_identifier = FactoryBot.build(:prosecution_case_identifier_with_reference,
                                                                  prosecutionAuthorityReference: 'XXYYZZ')
      cases.map(&:save!)
    end

    let(:params_hash) do
      { prosecutionCaseReference: 'XXYYZZ' }
    end

    it { is_expected.to include(cases.first) }
    it { is_expected.to include(cases.second) }
    it { is_expected.not_to include(cases.third) }

    context 'with a non matching reference' do
      let(:params_hash) do
        { prosecutionCaseReference: 'NOT EXISTENT' }
      end

      it { is_expected.to be_empty }
    end
  end

  context 'when searching by nationalInsuranceNumber' do
    let(:cases) { FactoryBot.create_list(:prosecution_case, 2) }
    let(:defendant) do
      FactoryBot.build(:defendant,
                       prosecution_case: nil,
                       defendable: FactoryBot.create(:person_defendant,
                                                     person: FactoryBot.create(:person, nationalInsuranceNumber: 'NH489223C')))
    end

    before do
      cases.first.defendants << defendant
      cases.first.save!
    end

    let(:params_hash) do
      { nationalInsuranceNumber: 'NH489223C' }
    end

    it { is_expected.to include(cases.first) }
    it { is_expected.not_to include(cases.second) }

    context 'with a non matching reference' do
      let(:params_hash) do
        { nationalInsuranceNumber: 'XJ812213C' }
      end

      it { is_expected.to be_empty }
    end
  end
end
# rubocop:enable Metrics/BlockLength
