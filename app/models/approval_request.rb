# frozen_string_literal: true

class ApprovalRequest < ApplicationRecord
  belongs_to :hearing

  validates :approvalType, presence: true, inclusion: %w[CHANGE APPROVAL]
  validates :hearing, presence: true
  validates :userId, presence: true
  validates :requestApprovalTime, presence: true

  def to_builder
    Jbuilder.new do |approval_request|
      approval_request.userId userId
      approval_request.approvalType approvalType
      approval_request.requestApprovalTime requestApprovalTime.to_datetime
      approval_request.hearingId hearing_id
    end
  end
end
