class AssociatedDefenceOrganisation < ApplicationRecord
 FUNDING_TYPES = %w(REPRESENTATION_ORDER REPRESENTATION_ORDER_APPLIED_FOR PRIVATE COURT_APPOINTED PRO_BONO)
 belongs_to :organisation
 validates :organisation, presence: true
 validates :fundingType, presence: true, inclusion: FUNDING_TYPES 
 validates :associationStartDate, presence: true
 validates :sraNumber, presence: true, if: -> { laaContractNumber.blank? && barCouncilMembershipNumber.blank? }
 validates :laaContractNumber, presence: true, if: -> { sraNumber.blank? && barCouncilMembershipNumber.blank? }
 validates :barCouncilMembershipNumber, presence: true, if: -> { sraNumber.blank? && laaContractNumber.blank? }

  def to_builder
    Jbuilder.new do |associated_defence_organisation|
      associated_defence_organisation.organisation organisation.to_builder
      associated_defence_organisation.fundingType fundingType
      associated_defence_organisation.associationStartDate associationStartDate.to_date
      associated_defence_organisation.associationEndDate associationEndDate.to_date
      associated_defence_organisation.isAssociatedByLAA isAssociatedByLAA
      associated_defence_organisation.sraNumber sraNumber 
      associated_defence_organisation.laaContractNumber laaContractNumber if sraNumber.blank? && barCouncilMembershipNumber.blank? 
      associated_defence_organisation.sraNumber sraNumber if laaContractNumber.blank? && barCouncilMembershipNumber.blank?
      associated_defence_organisation.barCouncilMembershipNumber barCouncilMembershipNumber if  sraNumber.blank? && laaContractNumber.blank?
    end
  end
end
