# frozen_string_literal: true

RSpec.describe Hearing, type: :model do
  subject { hearing }

  let(:hearing) { FactoryBot.create(:hearing) }
  let(:json_schema) { :hearing }

  describe "associations" do
    it { is_expected.to belong_to(:hearing_type).class_name("HearingType") }
    it { is_expected.to belong_to(:cracked_ineffective_trial).class_name("CrackedIneffectiveTrial").optional }
    it { is_expected.to have_many(:prosecution_case_hearings).class_name("ProsecutionCaseHearing") }
    it { is_expected.to have_many(:prosecution_cases).class_name("ProsecutionCase").through(:prosecution_case_hearings) }
    it { is_expected.to have_many(:court_applications).class_name("CourtApplication") }
    it { is_expected.to have_many(:referral_reasons).class_name("ReferralReason") }
    it { is_expected.to have_many(:hearing_case_notes).class_name("HearingCaseNote") }
    it { is_expected.to have_many(:hearing_days).class_name("HearingDay").dependent(:destroy) }
    it { is_expected.to have_many(:judicial_roles).class_name("JudicialRole") }
    it { is_expected.to have_many(:applicant_counsels).class_name("ApplicantCounsel") }
    it { is_expected.to have_many(:respondent_counsels).class_name("RespondentCounsel") }
    it { is_expected.to have_many(:prosecution_counsels).class_name("ProsecutionCounsel") }
    it { is_expected.to have_many(:defence_counsels).class_name("DefenceCounsel") }
    it { is_expected.to have_many(:court_application_party_counsels).class_name("CourtApplicationPartyCounsel") }
    it { is_expected.to have_many(:defendant_attendances).class_name("DefendantAttendance") }
    it { is_expected.to have_many(:court_application_party_attendances).class_name("CourtApplicationPartyAttendance") }
    it { is_expected.to have_many(:defendant_hearing_youth_markers).class_name("DefendantHearingYouthMarker") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:jurisdictionType) }
    it { is_expected.to validate_presence_of(:court_centre_id) }
    it { is_expected.to validate_presence_of(:hearing_type) }
    it { is_expected.to validate_inclusion_of(:jurisdictionType).in_array(%w[MAGISTRATES CROWN]) }
  end

  context "when the hearing has been resulted" do
    let(:hearing) { FactoryBot.create(:hearing, resulted: true) }
    let(:json_schema) { :results_hearing_resulted_response }

    it "matches the given schema" do
      expect(hearing.resulted_response).to match_json_schema(json_schema)
    end
  end

  it_has_behaviour "conforming to valid schema"

  context "with optional relationships" do
    before do
      hearing.cracked_ineffective_trial = FactoryBot.create(:cracked_ineffective_trial)
      hearing.prosecution_cases << FactoryBot.create(:prosecution_case)
      hearing.court_applications << FactoryBot.create(:court_application)
      hearing.referral_reasons << FactoryBot.create(:referral_reason)
      hearing.hearing_case_notes << FactoryBot.create(:hearing_case_note)
      hearing.judicial_roles << FactoryBot.create(:judicial_role)
      hearing.applicant_counsels << FactoryBot.create(:applicant_counsel)
      hearing.respondent_counsels << FactoryBot.create(:respondent_counsel)
      hearing.prosecution_counsels << FactoryBot.create(:prosecution_counsel)
      hearing.defence_counsels << FactoryBot.create(:defence_counsel)
      hearing.court_application_party_counsels << FactoryBot.create(:court_application_party_counsel)
      hearing.defendant_attendances << FactoryBot.create(:defendant_attendance)
      hearing.court_application_party_attendances << FactoryBot.create(:court_application_party_attendance)
      hearing.defendant_hearing_youth_markers << FactoryBot.create(:defendant_hearing_youth_marker)
      hearing.save!
    end

    it_has_behaviour "conforming to valid schema"

    context "when the hearing contains a 'cracked trial' outcome" do
      it "is associated to a cracked ineffective trial" do
        expect(hearing.cracked_ineffective_trial).to be_present
      end
    end

    context "when the hearing contains a plea" do
      let(:offence) { hearing.prosecution_cases.first.defendants.first.offences.first }
      let(:hearing_json) { subject.to_builder.attributes! }

      before do
        FactoryBot.create(:plea, offence: offence, hearing: hearing)
      end

      it_has_behaviour "conforming to valid schema"

      it "contains a plea object" do
        expect(hearing_json["prosecutionCases"][0]["defendants"][0]["offences"][0]["plea"]).not_to be_empty
      end
    end

    context "when the hearing contains an allocation decision" do
      let(:offence) { hearing.prosecution_cases.first.defendants.first.offences.first }
      let(:hearing_json) { subject.to_builder.attributes! }

      before do
        FactoryBot.create(:allocation_decision, offence: offence, hearing: hearing)
      end

      it_has_behaviour "conforming to valid schema"

      it "contains an allocation decision object" do
        expect(hearing_json["prosecutionCases"][0]["defendants"][0]["offences"][0]["allocationDecision"]).not_to be_empty
      end
    end

    context "when the hearing contains a verdict" do
      let(:offence) { hearing.prosecution_cases.first.defendants.first.offences.first }
      let(:hearing_json) { subject.to_builder.attributes! }

      before do
        FactoryBot.create(:verdict, offence: offence, hearing: hearing)
      end

      it_has_behaviour "conforming to valid schema"

      it "contains a verdict object" do
        expect(hearing_json["prosecutionCases"][0]["defendants"][0]["offences"][0]["verdict"]).not_to be_empty
      end
    end
  end
end
