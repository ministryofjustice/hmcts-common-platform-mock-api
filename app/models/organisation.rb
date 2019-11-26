# frozen_string_literal: true

class Organisation < ApplicationRecord
  belongs_to :address, optional: true
  belongs_to :contact, class_name: 'ContactNumber', optional: true

  validates :name, presence: true

  scope :by_name, ->(params) { where(name: params[:organisationName]) }

  def to_builder
    Jbuilder.new do |organisation|
      organisation.name name
      organisation.incorporationNumber incorporationNumber
      organisation.registeredCharityNumber registeredCharityNumber
      organisation.address address.to_builder if address.present?
      organisation.contact contact.to_builder if contact.present?
    end
  end
end
