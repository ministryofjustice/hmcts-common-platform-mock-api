# frozen_string_literal: true

class CourtApplicationOffence < ApplicationRecord
  belongs_to :offence
  belongs_to :court_application_case

  validates :offence, presence: true

  def to_builder
    Jbuilder.new do |court_application_offence|
      court_application_offence.offenceCode offenceCode
      court_application_offence.offence offence.to_builder
    end
  end
end
