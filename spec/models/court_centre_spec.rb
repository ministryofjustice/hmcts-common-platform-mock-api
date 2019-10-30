# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CourtCentre, type: :model do
  let(:court_centre) { FactoryBot.create(:court_centre) }

  let(:json_schema) { :court_centre }

  subject { court_centre }

  describe 'associations' do
    it { should belong_to(:address).class_name('Address').optional }
  end

  it_has_behaviour 'conforming to valid schema'

  context 'with relationships' do
    before do
      court_centre.address = FactoryBot.create(:address)
      court_centre.save!
    end

    it_has_behaviour 'conforming to valid schema'
  end
end
