class ContactNumber < ApplicationRecord
  def to_builder
    Jbuilder.new do |contact_number|
      contact_number.home home
      contact_number.work work
      contact_number.mobile mobile
      contact_number.primaryEmail primaryEmail
      contact_number.secondaryEmail secondaryEmail
      contact_number.fax fax
    end
  end
end
