# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe LaaRepresentationOrderRecorder do
  let(:params) { ActionController::Parameters.new(params_hash) }
  let(:defendant) { FactoryBot.create(:defendant) }
  let(:offence) { defendant.offences.first }
  let(:status_code) { 'STATUS CODE 999' }
  let(:application_reference) { 'APPLICATION REFERENCE 998' }
  let(:status_date) { '2019-12-10' }
  let(:effective_start_date) { '2019-12-12' }
  let(:effective_end_date) { '2019-12-20' }
  let(:defence_organisation) { FactoryBot.create(:defence_organisation) }
  let(:laa_reference) do
    FactoryBot.create(:laa_reference,
                      statusCode: status_code,
                      applicationReference: application_reference,
                      statusDate: status_date,
                      offence: offence)
  end

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

  context 'with valid params' do
    let(:params_hash) do
      {
        prosecutionCaseId: defendant.prosecution_case.id,
        defendantId: defendant.id,
        offenceId: offence.id,
        statusCode: status_code,
        applicationReference: application_reference,
        statusDate: status_date,
        effectiveStartDate: effective_start_date,
        effectiveEndDate: effective_end_date,
        defenceOrganisation: defence_organisation.to_builder.attributes!
      }
    end

    context 'when an LaaReference does not exist' do
      it 'creates the LaaReference' do
        expect { subject }.to change(LaaReference, :count).by(1)
      end
    end

    context 'when the LaaReference exists' do
      before { laa_reference.save! }

      it 'does not create a new LaaReference' do
        expect { subject }.to change(LaaReference, :count).by(0)
      end

      it 'updates the LaaReference' do
        subject
        laa_reference.reload
        expect(laa_reference.statusCode).to eq(status_code)
        expect(laa_reference.applicationReference).to eq(application_reference)
        expect(laa_reference.statusDate).to eq(status_date)
        expect(laa_reference.effectiveStartDate).to eq(effective_start_date)
        expect(laa_reference.effectiveEndDate).to eq(effective_end_date)
      end

      it { is_expected.to eq laa_reference }
    end
  end
end
# rubocop:enable Metrics/BlockLength
