# frozen_string_literal: true

class DefenceOrganisation < ApplicationRecord
  FUNDING_TYPES = %w[REPRESENTATION_ORDER REPRESENTATION_ORDER_APPLIED_FOR PRIVATE COURT_APPOINTED PRO_BONO].freeze

  belongs_to :organisation
  belongs_to :defendant, optional: true, inverse_of: :defence_organisation

  accepts_nested_attributes_for :organisation, reject_if: :all_blank

  validates :organisation, presence: true
  validates :laaContractNumber, presence: true

  validates :fundingType, presence: true, inclusion: FUNDING_TYPES, if: -> { defendant.present? }
  validates :associationStartDate, presence: true, if: -> { defendant.present? }

  def to_builder
    Jbuilder.new do |defence_organisation|
      defence_organisation.organisation organisation.to_builder
      if associated_defence_organisation?
        defence_organisation.fundingType fundingType
        defence_organisation.associationStartDate associationStartDate.to_date
        defence_organisation.associationEndDate associationEndDate.to_date
        defence_organisation.isAssociatedByLAA isAssociatedByLAA
        defence_organisation.applicationReference application_reference
      else
        defence_organisation.laaContractNumber laaContractNumber
      end
    end
  end

  def application_reference
    return nil unless associated_defence_organisation?

    defendant.laa_references.map(&:applicationReference).compact.uniq.first
  end

  private

  def associated_defence_organisation?
    defendant.present?
  end
end
