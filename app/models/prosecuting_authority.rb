# frozen_string_literal: true

class ProsecutingAuthority < ApplicationRecord
  belongs_to :address, optional: true
  belongs_to :contact, class_name: 'ContactNumber', optional: true

  validates :prosecutionAuthorityCode, presence: true

  def to_builder
    Jbuilder.new do |prosecuting_authority|
      prosecuting_authority.accountCode accountCode
      prosecuting_authority.address address.to_builder if address.present?
      prosecuting_authority.contact contact.to_builder if contact.present?
      prosecuting_authority.name name
      prosecuting_authority.prosecutionAuthorityCode prosecutionAuthorityCode
      prosecuting_authority.prosecutionAuthorityId prosecutionAuthorityId
    end
  end
end
