# frozen_string_literal: true

class ReferralReason < ApplicationRecord
  validates :description, presence: true
  validates :defendantId, presence: true

  def to_builder
    Jbuilder.new do |referral_reason|
      referral_reason.id id
      referral_reason.description description
      referral_reason.defendantId defendantId
    end
  end
end
