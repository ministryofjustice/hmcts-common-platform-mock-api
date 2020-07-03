# frozen_string_literal: true

class ProsecutionCaseHearing < ApplicationRecord
  belongs_to :prosecution_case
  belongs_to :hearing
end
