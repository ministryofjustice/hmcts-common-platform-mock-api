# frozen_string_literal: true

module CourtCentreRelatable
  extend ActiveSupport::Concern

  included do
    def court_centre
      return if court_centre_id.blank?

      @court_centre ||= CourtCentre.new(id: court_centre_id)
    end
  end
end
