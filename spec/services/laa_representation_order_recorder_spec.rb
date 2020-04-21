# frozen_string_literal: true

RSpec.describe LaaRepresentationOrderRecorder do
  let(:params) { ActionController::Parameters.new(params_hash) }
  let(:defendant) { FactoryBot.create(:defendant) }
  let(:offence) { defendant.offences.first }
  let(:status_code) { 'STATUS CODE 999' }
  let(:application_reference) { 'APPLICATION REFERENCE 998' }
  let(:status_date) { '2019-12-10' }
  let(:effective_start_date) { '2019-12-12' }
  let(:effective_end_date) { '2019-12-20' }
  let(:defence_organisation_params) do
    {
      organisation: {
        name: 'Unlimited Solicitors'
      },
      laaContractNumber: 'ZYXWVU'
    }
  end
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
        defenceOrganisation: defence_organisation_params
      }
    end

    context 'when an LaaReference does not exist' do
      it 'creates the LaaReference' do
        expect { subject }.to change(LaaReference, :count).by(1)
      end
    end

    context 'when a DefenceOrganisation does not exist' do
      it 'creates the DefenceOrganisation' do
        expect { subject }.to change(DefenceOrganisation, :count).by(1)
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

    context 'when the DefenceOrganisation exists' do
      let!(:defence_organisation) { FactoryBot.create(:associated_defence_organisation, defendant: defendant) }
      let(:address_hash) do
        {
          address1: '788 Rau Court',
          address2: 'Apt. 384',
          address3: '4324',
          address4: 'Lake Pamala',
          address5: 'UK',
          postcode: 'W1D 2LR'
        }
      end

      let(:contact_hash) do
        {
          home: '1-445-317-3241',
          work: '(314) 470-7790',
          mobile: '930-170-8637',
          primaryEmail: 'piper_will@lueilwitzpfeffer.org',
          secondaryEmail: 'otto.frami@schaefer.co',
          fax: '648-536-8278 x55542'
        }
      end

      let(:defence_organisation_params) do
        {
          organisation: {
            name: 'Unlimited Solicitors',
            incorporationNumber: 'ABCDE',
            registeredCharityNumber: 'FGHIJ',
            address: address_hash,
            contact: contact_hash
          },
          laaContractNumber: 'ZYXWVU'
        }
      end

      it 'does not create a new DefenceOrganisation' do
        expect { subject }.to change(DefenceOrganisation, :count).by(0)
      end

      it 'updates the DefenceOrganisation' do
        subject
        defence_organisation.reload
        expect(defence_organisation.organisation.name).to eq('Unlimited Solicitors')
        expect(defence_organisation.organisation.incorporationNumber).to eq('ABCDE')
        expect(defence_organisation.organisation.registeredCharityNumber).to eq('FGHIJ')
        expect(defence_organisation.organisation.address).to have_attributes(address_hash)
        expect(defence_organisation.organisation.contact).to have_attributes(contact_hash)
        expect(defence_organisation.laaContractNumber).to eq('ZYXWVU')
        expect(defence_organisation.fundingType).to eq('REPRESENTATION_ORDER')
        expect(defence_organisation.associationStartDate).to eq(effective_start_date)
        expect(defence_organisation.associationEndDate).to eq(effective_end_date)
        expect(defence_organisation.isAssociatedByLAA).to eq(true)
      end
    end
  end
end
