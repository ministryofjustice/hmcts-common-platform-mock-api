# frozen_string_literal: true

class Applicant < ApplicationRecord
  belongs_to :applicant_counsel, optional: true
end
