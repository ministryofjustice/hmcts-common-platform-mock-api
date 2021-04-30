require "rails_helper"

RSpec.describe CommittingCourt, type: :model do
  subject { committing_court }

  let(:committing_court) { FactoryBot.create(:committing_court) }

  let(:json_schema) { :committing_court }

  describe "validations" do
    it { is_expected.to validate_presence_of(:court_centre_id) }
    it { is_expected.to validate_presence_of(:court_house_name) }
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
