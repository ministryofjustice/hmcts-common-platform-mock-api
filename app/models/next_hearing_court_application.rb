# frozen_string_literal: true

class NextHearingCourtApplication < ApplicationRecord
  belongs_to :next_hearing, optional: true, inverse_of: :next_hearing_court_applications
end
