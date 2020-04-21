# frozen_string_literal: true

RSpec.describe LjaDetails, type: :model do
  let(:lja_details) { FactoryBot.create(:lja_details) }

  let(:json_schema) { :lja_details }

  subject { lja_details }

  describe 'validations' do
    it { should validate_presence_of(:ljaCode) }
    it { should validate_presence_of(:ljaName) }
  end

  describe 'associations' do
    it { should have_one(:court_centre).class_name('CourtCentre') }
  end

  it_has_a 'realistic factory'

  it_has_behaviour 'conforming to valid schema'

  context 'with relationships' do
    before do
      lja_details.update!(court_centre: FactoryBot.create(:court_centre))
    end

    it_has_behaviour 'conforming to valid schema'
  end
end
