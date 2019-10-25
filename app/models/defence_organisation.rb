# frozen_string_literal: true

class DefenceOrganisation < ApplicationRecord
  belongs_to :organisation

  validates :organisation, presence: true
  validates :laaContractNumber, presence: true, if: -> { sraNumber.blank? && barCouncilMembershipNumber.blank? }
  validates :sraNumber, presence: true, if: -> { laaContractNumber.blank? && barCouncilMembershipNumber.blank? }
  validates :barCouncilMembershipNumber, presence: true, if: -> { laaContractNumber.blank? && sraNumber.blank? }

  def to_builder
    Jbuilder.new do |defence_organisation|
      defence_organisation.organisation organisation.to_builder
      defence_organisation.laaContractNumber laaContractNumber if laaContractNumber.present?
      defence_organisation.sraNumber sraNumber if sraNumber.present?
      defence_organisation.barCouncilMembershipNumber barCouncilMembershipNumber if barCouncilMembershipNumber.present?
    end
  end
end
