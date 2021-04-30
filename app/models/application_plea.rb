class ApplicationPlea < ApplicationRecord
  include BuilderMappable

  belongs_to :delegated_powers
  belongs_to :lesser_or_alternative_offence

  validates :application_id, presence: true
  validates :plea_date, presence: true
  validates :plea_value, presence: true

  def to_builder
    Jbuilder.new do |application_plea|
      application_plea.originatingHearingId originating_hearing_id
      application_plea.delegatedPowers delegated_powers.to_builder
      application_plea.applicationId application_id
      application_plea.pleaDate plea_date
      application_plea.pleaValue plea_value
      application_plea.lesserOrAlternativeOffence lesser_or_alternative_offence.to_builder
    end
  end
end
