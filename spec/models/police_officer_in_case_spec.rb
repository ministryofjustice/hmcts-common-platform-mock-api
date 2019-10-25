# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PoliceOfficerInCase, type: :model do
  let(:police_officer_in_case) { FactoryBot.create(:police_officer_in_case) }
  let(:json_schema) { :police_officer_in_case }

  subject { police_officer_in_case }

  describe 'associations' do
    it { should belong_to(:person).class_name('Person').required }
  end
  describe 'validations' do
    it { should validate_presence_of(:person) }
    it { should validate_presence_of(:policeOfficerRank) }
    it { should validate_presence_of(:policeWorkerReferenceNumber) }
    it { should validate_presence_of(:policeWorkerLocationCode) }
  end

  it_has_behaviour 'conforming to valid schema'

end
