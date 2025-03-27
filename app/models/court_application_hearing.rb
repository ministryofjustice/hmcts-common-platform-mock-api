# frozen_string_literal: true

class CourtApplicationHearing < ApplicationRecord
  belongs_to :court_application
  belongs_to :hearing
end
