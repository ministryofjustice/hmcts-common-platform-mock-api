# frozen_string_literal: true
require 'yaml'

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
    end
  end

  def self.select_options
    records.map do |record|
      [
        record["reason_short_desc"],
        record["id"],
      ]
    end
  end

  def self.records
    @data ||= YAML.load_file('lib/data/cracked_ineffective_trial.yml')
  end
end
