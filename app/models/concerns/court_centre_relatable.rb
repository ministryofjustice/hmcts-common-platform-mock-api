# frozen_string_literal: true

module CourtCentreRelatable
  extend ActiveSupport::Concern

  included do
    def court_centre
      return if court_centre_id.blank?

      @court_centre ||= CourtCentre.find_by(id: court_centre_id)
    end
  end
end
