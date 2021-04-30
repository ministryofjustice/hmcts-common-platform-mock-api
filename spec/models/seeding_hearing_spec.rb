require "rails_helper"

RSpec.describe SeedingHearing, type: :model do
  subject { seeding_hearing }

  let(:seeding_hearing) { FactoryBot.create(:seeding_hearing) }

  let(:json_schema) { :seeding_hearing }

  describe "validations" do
    it { is_expected.to validate_presence_of(:seeding_hearing_id) }
    it { is_expected.to validate_presence_of(:jurisdiction_type) }
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
