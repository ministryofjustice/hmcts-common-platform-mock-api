class LaaReference < ApplicationRecord
  validates :applicationReference, presence: true
  validates :statusId, presence: true
  validates :statusCode, presence: true
  validates :statusDescription, presence: true
  validates :statusDate, presence: true

  def to_builder
    Jbuilder.new do |laa_reference|
      laa_reference.applicationReference applicationReference
      laa_reference.statusId statusId
      laa_reference.statusCode statusCode
      laa_reference.statusDescription statusDescription
      laa_reference.statusDate statusDate.to_date
      laa_reference.effectiveStartDate effectiveStartDate.to_date
      laa_reference.effectiveEndDate effectiveEndDate.to_date
    end
  end
end
