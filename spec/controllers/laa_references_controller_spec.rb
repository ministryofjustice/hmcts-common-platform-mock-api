# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LaaReferencesController, type: :controller do
  describe 'PUT #record' do
    let(:defendant) { FactoryBot.create(:defendant) }
    let(:offence) { defendant.offences.first }
    let(:status_code) { 'STATUS CODE 999' }
    let(:application_reference) { 'APPLICATION REFERENCE 998' }
    let(:status_date) { '2019-12-12' }
    let(:laa_reference) { FactoryBot.create(:laa_reference, offence: offence) }

    let(:laa_reference_params) do
      {
        id: laa_reference_id,
        prosecutionCaseId: defendant.prosecution_case.id,
        defendantId: defendant.id,
        offenceId: offence.id,
        statusCode: status_code,
        applicationReference: application_reference,
        statusDate: status_date
      }
    end

    context 'when the LaaReference exists' do
      let(:laa_reference_id) { laa_reference.id }

      it 'returns a no_content status' do
        put :record, params: laa_reference_params
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the LaaReference is new' do
      let(:laa_reference_id) { SecureRandom.uuid }

      it 'returns a created status' do
        put :record, params: laa_reference_params
        expect(response).to have_http_status(:created)
      end
    end
  end
end
