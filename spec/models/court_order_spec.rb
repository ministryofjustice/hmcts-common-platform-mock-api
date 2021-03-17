require "rails_helper"

RSpec.describe CourtOrder, type: :model do
  subject { court_order }

  let(:court_order) { FactoryBot.create(:court_order) }

  let(:json_schema) { :court_order }

  describe "associations" do
    it { is_expected.to have_many(:court_order_offences).class_name("CourtOrderOffence") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:id) }
    it { is_expected.to validate_presence_of(:judicial_result_type_id) }
    it { is_expected.to validate_presence_of(:label) }
    it { is_expected.to validate_presence_of(:order_date) }
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:court_centre_id) }
    it { is_expected.to validate_presence_of(:ordering_hearing_id) }
    it { is_expected.to validate_presence_of(:court_order_offences) }
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
