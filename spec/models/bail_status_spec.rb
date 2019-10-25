# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BailStatus, type: :model do
  let(:bail_status) { FactoryBot.create(:bail_status) }

  let(:json_schema) { :bail_status }

  subject { bail_status }

  describe 'associations' do
    it { should belong_to(:custody_time_limit).class_name('CustodyTimeLimit').optional }
  end
  describe 'validations' do
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:description) }
  end

  context 'hmcts schema' do
    it_has_behaviour 'conforming to valid schema'

    context 'with relationships' do
      before do
        subject.update! custody_time_limit: FactoryBot.create(:custody_time_limit)
      end

      it_has_behaviour 'conforming to valid schema'
    end
  end
end
