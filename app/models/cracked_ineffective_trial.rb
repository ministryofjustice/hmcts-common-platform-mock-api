# frozen_string_literal: true

class CrackedIneffectiveTrial < ApplicationRecord
  validates :code, presence: true
  validates :description, presence: true
  validates :reason_type, presence: true

  def to_builder
    Jbuilder.new do |cracked_ineffective_trial|
      cracked_ineffective_trial.id id
      cracked_ineffective_trial.code code
      cracked_ineffective_trial.description description
      cracked_ineffective_trial.type reason_type
      cracked_ineffective_trial.date date
    end
  end
end
