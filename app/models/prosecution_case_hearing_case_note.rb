# frozen_string_literal: true

class ProsecutionCaseHearingCaseNote < ApplicationRecord
  belongs_to :prosecution_case
  belongs_to :hearing_case_note
end
