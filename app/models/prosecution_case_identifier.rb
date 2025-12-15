# frozen_string_literal: true

class ProsecutionCaseIdentifier < ApplicationRecord
  belongs_to :address, optional: true
  belongs_to :contact_number, optional: true

  validates :prosecutionAuthorityId, presence: true
  validates :prosecutionAuthorityCode, presence: true
  validates :prosecutionAuthorityReference, presence: true, if: -> { caseURN.blank? }
  validate :validate_case_urn

  scope :by_reference, lambda { |reference|
    where('LOWER("caseURN") = :reference OR LOWER("prosecution_case_identifiers"."prosecutionAuthorityReference") = :reference',
          reference: reference.downcase)
  }

  def validate_case_urn
    if prosecutionAuthorityReference.blank? && caseURN.blank?
      errors.add(:caseURN, "can't be blank")
    elsif caseURN.present?
      if caseURN.length != 11
        errors.add(:caseURN, "caseURN should be 11 characters")
      end
      unless /\A[a-zA-Z0-9]*\z/.match?(caseURN)
        errors.add(:caseURN, "Only allows alphanumeric letters")
      end
    end
  end

  def to_builder
    Jbuilder.new do |prosecution_case_identifier|
      prosecution_case_identifier.caseURN caseURN if caseURN.present?
      prosecution_case_identifier.prosecutionAuthorityReference prosecutionAuthorityReference if prosecutionAuthorityReference.present?
      prosecution_case_identifier.prosecutionAuthorityId prosecutionAuthorityId
      prosecution_case_identifier.prosecutionAuthorityCode prosecutionAuthorityCode
      prosecution_case_identifier.prosecutionAuthorityName prosecution_authority_name
      prosecution_case_identifier.prosecutionAuthorityOUCode prosecution_authority_oucode
      prosecution_case_identifier.majorCreditorCode major_creditor_code
      prosecution_case_identifier.address address.to_builder if address.present?
      prosecution_case_identifier.contact contact_number.to_builder if contact_number.present?
    end
  end
end
