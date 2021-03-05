class ApprovalRequest < ApplicationRecord
  APPROVAL_TYPES = %w[CHANGE
                      APPROVAL].freeze

  validates :hearing_id, presence: true
  validates :approval_type, presence: true
  validates :user_id, presence: true
  validates :request_approval_time, presence: true

  def to_builder
    Jbuilder.new do |approval_request|
      approval_request.hearingId hearing_id
      approval_request.userId user_id
      approval_request.requestApprovalTime request_approval_time
      approval_request.approvalType approval_type
    end
  end
end
