require "rails_helper"

RSpec.describe CompanyRepresentative, type: :model do
  subject { company_representative }

  let(:company_representative) { FactoryBot.create(:company_representative) }

  let(:json_schema) { :company_representative }

  describe "validations" do
    it { is_expected.to validate_presence_of(:id) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:position) }
    it { is_expected.to validate_presence_of(:defendants) }
    it { is_expected.to validate_presence_of(:attendance_days) }
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
