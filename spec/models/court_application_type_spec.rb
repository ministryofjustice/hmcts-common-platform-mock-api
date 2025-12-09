# frozen_string_literal: true

RSpec.describe CourtApplicationType, type: :model do
  subject { court_application_type }

  let(:court_application_type) { FactoryBot.create(:court_application_type) }
  let(:json_schema) { :court_application_type }

  describe "validations" do
    it { is_expected.to validate_presence_of(:type) }
    it { is_expected.to validate_presence_of(:category_code) }
    it { is_expected.to validate_presence_of(:linkType) }
    it { is_expected.to validate_presence_of(:jurisdiction) }
    it { is_expected.to validate_presence_of(:summons_template_type) }
    it { is_expected.to validate_presence_of(:breach_type) }
    it { is_expected.to validate_presence_of(:appeal_flag) }
    it { is_expected.to validate_presence_of(:applicant_appellant_flag) }
    it { is_expected.to validate_presence_of(:plea_applicable_flag) }
    it { is_expected.to validate_presence_of(:commr_of_oath_flag) }
    it { is_expected.to validate_presence_of(:court_of_appeal_flag) }
    it { is_expected.to validate_presence_of(:court_extract_avl_flag) }
    it { is_expected.to validate_presence_of(:prosecutor_third_party_flag) }
    it { is_expected.to validate_presence_of(:spi_out_applicable_flag) }
    it { is_expected.to validate_presence_of(:offence_active_order) }
  end

  it do
    is_expected.to validate_inclusion_of(:linkType)
      .in_array(%w[STANDALONE LINKED NEITHER])
  end

  describe "before save callback" do
    it "updates category and type based on code" do
      court_application_type.save!
      expect(court_application_type.category_code).to eq("appeal")
      expect(court_application_type.type).to eq("Appeal against conviction and sentence by a Magistrates' Court to the Crown Court")
    end
  end

  it_has_behaviour "conforming to valid schema"
end
