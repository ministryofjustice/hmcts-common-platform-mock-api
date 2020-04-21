# frozen_string_literal: true

RSpec.describe DefendantCustodyLocation, type: :model do
  let(:defendant_custody_location) { FactoryBot.create(:defendant_custody_location) }

  let(:json_schema) { :defendant_custody_location }

  subject { defendant_custody_location }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:emailAddress) }
    it { should validate_presence_of(:locationType) }
    it { should validate_inclusion_of(:locationType).in_array(%w[POLICESTATION PRISON DETENTIONCENTRE]) }
  end

  describe 'associations' do
    it { should belong_to(:address).class_name('Address') }
  end

  it_has_a 'realistic factory'

  it_has_behaviour 'conforming to valid schema'
end
