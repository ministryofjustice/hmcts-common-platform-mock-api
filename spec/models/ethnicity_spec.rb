# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ethnicity, type: :model do
  let(:ethnicity) { FactoryBot.create(:ethnicity) }

  let(:json_schema) { :ethnicity }

  subject { ethnicity }

  it 'matches the given schema' do
    expect(ethnicity.to_builder.target!).to match_json_schema(:ethnicity)
  end

  describe 'associations' do
    it { should have_one(:person).class_name('Person') }
  end

  it_has_behaviour 'conforming to valid schema'

end
