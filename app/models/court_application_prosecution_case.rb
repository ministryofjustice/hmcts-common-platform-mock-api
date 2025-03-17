class CourtApplicationProsecutionCase < ApplicationRecord
  belongs_to :court_application
  belongs_to :prosecution_case
end
