# frozen_string_literal: true

RSpec.describe ProsecutionCaseSearch do
  let(:params) { ActionController::Parameters.new(params_hash) }
  let(:john_doe) { FactoryBot.create(:person, firstName: 'John', lastName: 'Doe', dateOfBirth: '2000-01-10') }

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
    let(:cases) { build_list(:prosecution_case, 3) }

    before do
      cases.first.prosecution_case_identifier = build(:prosecution_case_identifier,
                                                      caseURN: 'XXYYZZ')
      cases.second.prosecution_case_identifier = build(:prosecution_case_identifier_with_reference,
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
        { prosecutionCaseReference: 'NON EXISTENT' }
      end

      it { is_expected.to be_empty }
    end
  end

  context 'when searching by nationalInsuranceNumber' do
    let(:cases) { FactoryBot.create_list(:prosecution_case, 2) }
    let(:defendant) do
      build(:defendant,
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

  context 'when searching by arrestSummonsNumber' do
    let(:cases) { FactoryBot.create_list(:prosecution_case, 2) }
    let(:defendant) do
      build(:defendant,
            prosecution_case: nil,
            defendable: FactoryBot.create(:person_defendant, arrestSummonsNumber: '3.1428'))
    end

    before do
      cases.first.defendants << defendant
      cases.first.save!
    end

    let(:params_hash) do
      { arrestSummonsNumber: '3.1428' }
    end

    it { is_expected.to include(cases.first) }
    it { is_expected.not_to include(cases.second) }

    context 'with a non matching reference' do
      let(:params_hash) do
        { arrestSummonsNumber: 'NON EXISTENT' }
      end

      it { is_expected.to be_empty }
    end
  end

  context 'when searching by name and dateOfBirth' do
    let(:cases) { FactoryBot.create_list(:prosecution_case, 2) }
    let(:defendant) do
      build(:defendant,
            prosecution_case: nil,
            defendable: FactoryBot.create(:person_defendant,
                                          person: john_doe))
    end

    before do
      cases.first.defendants << defendant
      cases.first.save!
    end

    let(:params_hash) do
      { dateOfBirth: '2000-01-10', name: { firstName: 'John', lastName: 'Doe' } }
    end

    it { is_expected.to include(cases.first) }
    it { is_expected.not_to include(cases.second) }

    context 'with a non matching reference' do
      let(:params_hash) do
        { dateOfBirth: '2012-12-12', name: { firstName: 'John', lastName: 'Doe' } }
      end

      it { is_expected.to be_empty }
    end
  end

  context 'when searching by name and dateOfNextHearing' do
    let(:cases) { FactoryBot.create_list(:prosecution_case, 2) }
    let(:defendant) do
      build(:defendant, :with_next_hearing,
            next_hearing_date: '2019-01-10',
            prosecution_case: nil,
            defendable: FactoryBot.create(:person_defendant, person: john_doe))
    end

    before do
      cases.first.defendants << defendant
      cases.first.save!
    end

    let(:params_hash) do
      { dateOfNextHearing: '2019-01-10', name: { firstName: 'John', lastName: 'Doe' } }
    end

    it { is_expected.to include(cases.first) }
    it { is_expected.not_to include(cases.second) }

    context 'with a non matching reference' do
      let(:params_hash) do
        { dateOfNextHearing: '2029-01-10', name: { firstName: 'John', lastName: 'Doe' } }
      end

      it { is_expected.to be_empty }
    end
  end
end
