# frozen_string_literal: true

class DefenceOrganisation < ApplicationRecord
  FUNDING_TYPES = %w[REPRESENTATION_ORDER REPRESENTATION_ORDER_APPLIED_FOR PRIVATE COURT_APPOINTED PRO_BONO].freeze

  belongs_to :organisation
  belongs_to :defendant, optional: true, inverse_of: :defence_organisations

  validates :organisation, presence: true
  validates :laaContractNumber, presence: true, if: -> { sraNumber.blank? && barCouncilMembershipNumber.blank? }
  validates :sraNumber, presence: true, if: -> { laaContractNumber.blank? && barCouncilMembershipNumber.blank? }
  validates :barCouncilMembershipNumber, presence: true, if: -> { laaContractNumber.blank? && sraNumber.blank? }

  validates :fundingType, presence: true, inclusion: FUNDING_TYPES, if: -> { defendant.present? }
  validates :associationStartDate, presence: true, if: -> { defendant.present? }

  def to_builder
    Jbuilder.new do |defence_organisation|
      defence_organisation.organisation organisation.to_builder
      defence_organisation.laaContractNumber laaContractNumber if laaContractNumber.present?
      defence_organisation.sraNumber sraNumber if sraNumber.present?
      defence_organisation.barCouncilMembershipNumber barCouncilMembershipNumber if barCouncilMembershipNumber.present?
      if defendant.present?
        defence_organisation.fundingType fundingType
        defence_organisation.associationStartDate associationStartDate.to_date
        defence_organisation.associationEndDate associationEndDate.to_date
        defence_organisation.isAssociatedByLAA isAssociatedByLAA
      end
    end
  end
end
