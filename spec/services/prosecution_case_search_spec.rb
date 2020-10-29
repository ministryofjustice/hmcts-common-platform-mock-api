# frozen_string_literal: true

RSpec.describe ProsecutionCaseSearch do
  let(:params) { ActionController::Parameters.new(params_hash) }
  let(:john_doe) { FactoryBot.create(:person, firstName: 'John', lastName: 'Doe', dateOfBirth: '2000-01-10') }
  let(:defendant) do
    build(:defendant,
          prosecution_case: nil,
          defendable: FactoryBot.create(:person_defendant,
                                        person: FactoryBot.create(:person, nationalInsuranceNumber: 'nh489223c')))
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

  context 'when searching by prosecutionCaseReference' do
    let(:cases) { build_list(:prosecution_case, 3) }

    before do
      cases.first.prosecution_case_identifier = build(:prosecution_case_identifier,
                                                      caseURN: 'xxyyzz')
      cases.second.prosecution_case_identifier = build(:prosecution_case_identifier_with_reference,
                                                       prosecutionAuthorityReference: 'XXYYZZ')
      cases.map(&:save!)
    end

    let(:params_hash) do
      { prosecutionCaseReference: 'XXYYZZ' }
    end

    it { is_expected.to include(cases.first, cases.second) }
    it { is_expected.not_to include(cases.third) }

    context 'and NINO' do
      let(:params_hash) do
        { prosecutionCaseReference: 'XXYYZZ',
          defendantNINO: 'NH489223C' }
      end

      before do
        cases.first.defendants << defendant
        cases.first.save!
      end

      it { is_expected.to include(cases.first) }
      it { is_expected.not_to include(cases.second, cases.third) }
    end

    context 'and ASN' do
      let(:defendant) do
        build(:defendant,
              prosecution_case: nil,
              defendable: FactoryBot.create(:person_defendant, arrestSummonsNumber: '3.1428r'))
      end

      let(:defendant_two) do
        build(:defendant,
              prosecution_case: nil,
              defendable: FactoryBot.create(:person_defendant, arrestSummonsNumber: '3.1428r'))
      end

      let(:params_hash) do
        { prosecutionCaseReference: 'XXYYZZ',
          defendantASN: '3.1428R' }
      end

      before do
        cases.first.defendants << defendant
        cases.first.save!
        cases.third.defendants << defendant_two
        cases.third.save!
      end

      it { is_expected.to include(cases.first) }
      it { is_expected.not_to include(cases.second, cases.third) }
    end

    context 'and name and DOB' do
      let(:defendant) do
        build(:defendant,
              prosecution_case: nil,
              defendable: FactoryBot.create(:person_defendant,
                                            person: john_doe))
      end

      let(:defendant_two) do
        build(:defendant,
              prosecution_case: nil,
              defendable: FactoryBot.create(:person_defendant,
                                            person: john_doe))
      end

      let(:params_hash) do
        { prosecutionCaseReference: 'XXYYZZ',
          defendantDOB: '2000-01-10', defendantName: 'John Doe' }
      end

      before do
        cases.first.defendants << defendant
        cases.first.save!
        cases.third.defendants << defendant_two
        cases.third.save!
      end

      it { is_expected.to include(cases.first) }
      it { is_expected.not_to include(cases.second, cases.third) }
    end

    context 'and Date of next hearing' do
      let(:defendant) do
        build(:defendant, :with_next_hearing,
              next_hearing_date: '2019-01-10',
              prosecution_case: nil,
              defendable: FactoryBot.create(:person_defendant, person: john_doe))
      end

      let(:params_hash) do
        { prosecutionCaseReference: 'XXYYZZ',
          dateOfNextHearing: '2019-01-10', defendantName: 'John Doe' }
      end

      let(:defendant_two) do
        build(:defendant, :with_next_hearing,
              next_hearing_date: '2019-01-10',
              prosecution_case: nil,
              defendable: FactoryBot.create(:person_defendant, person: john_doe))
      end

      before do
        cases.first.defendants << defendant
        cases.first.save!
        cases.third.defendants << defendant_two
        cases.third.save!
      end

      it { is_expected.to include(cases.first) }
      it { is_expected.not_to include(cases.second, cases.third) }
    end

    context 'with a non matching reference' do
      let(:params_hash) do
        { prosecutionCaseReference: 'NON EXISTENT' }
      end

      it { is_expected.to be_empty }
    end
  end

  context 'when searching by defendantNINO' do
    let(:cases) { FactoryBot.create_list(:prosecution_case, 2) }

    before do
      cases.first.defendants << defendant
      cases.first.save!
    end

    let(:params_hash) do
      { defendantNINO: 'NH489223C' }
    end

    it { is_expected.to include(cases.first) }
    it { is_expected.not_to include(cases.second) }

    context 'with a non matching reference' do
      let(:params_hash) do
        { defendantNINO: 'XJ812213C' }
      end

      it { is_expected.to be_empty }
    end
  end

  context 'when searching by defendantASN' do
    let(:cases) { FactoryBot.create_list(:prosecution_case, 2) }
    let(:defendant) do
      build(:defendant, :with_next_hearing,
            next_hearing_date: '2019-01-10',
            prosecution_case: nil,
            defendable: FactoryBot.create(:person_defendant,
                                          arrestSummonsNumber: '3.1428r',
                                          person: FactoryBot.create(:person, nationalInsuranceNumber: 'nh489223c')))
    end

    before do
      cases.first.defendants << defendant
      cases.first.save!
    end

    let(:params_hash) do
      { defendantASN: '3.1428R' }
    end

    it { is_expected.to include(cases.first) }
    it { is_expected.not_to include(cases.second) }

    context 'with a non matching reference' do
      let(:params_hash) do
        { defendantASN: 'NON EXISTENT' }
      end

      it { is_expected.to be_empty }
    end

    context 'and NINO and name/DOB' do
      let(:params_hash) do
        { defendantASN: '3.1428R',
          defendantNINO: 'NH489223C',
          defendantDOB: '1971-05-12',
          defendantName: 'Parker',
          dateOfNextHearing: '2019-01-10' }
      end

      it { is_expected.to include(cases.first) }
      it { is_expected.not_to include(cases.second) }
    end
  end

  context 'when searching by defendantName and dateOfBirth' do
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
      { defendantDOB: '2000-01-10', defendantName: 'John Doe' }
    end

    it { is_expected.to include(cases.first) }
    it { is_expected.not_to include(cases.second) }

    context 'with a non matching reference' do
      let(:params_hash) do
        { defendantDOB: '2012-12-12', defendantName: 'John Doe' }
      end

      it { is_expected.to be_empty }
    end
  end

  context 'when searching by defendantName and dateOfNextHearing' do
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
      { dateOfNextHearing: '2019-01-10', defendantName: 'John Doe' }
    end

    it { is_expected.to include(cases.first) }
    it { is_expected.not_to include(cases.second) }

    context 'with a non matching reference' do
      let(:params_hash) do
        { dateOfNextHearing: '2029-01-10', defendantName: 'John Doe' }
      end

      it { is_expected.to be_empty }
    end
  end
end
