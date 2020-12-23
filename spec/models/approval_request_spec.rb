# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApprovalRequest, type: :model do
  let(:approval_request) { FactoryBot.create(:approval_request) }
  let(:json_schema) { :approval_request }

  subject { approval_request }

  describe 'associations' do
    it { should belong_to(:hearing).class_name('Hearing') }
  end

  describe 'validations' do
    it { should validate_presence_of(:hearing) }
    it { should validate_presence_of(:userId) }
    it { should validate_presence_of(:requestApprovalTime) }
    it { should validate_presence_of(:approvalType) }
    it { should validate_inclusion_of(:approvalType).in_array(%w[CHANGE APPROVAL]) }
  end

  it_has_behaviour 'conforming to valid schema'
end
