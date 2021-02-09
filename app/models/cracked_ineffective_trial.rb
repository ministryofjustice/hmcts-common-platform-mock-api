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

  def self.cracked_ineffective_trial_types
    @cracked_ineffective_trial_types ||= YAML.load_file('lib/data/cracked_ineffective_trial.yml')
  end

  def self.select_options
    cracked_ineffective_trial_types.map {|trial_type| [trial_type["reason_short_desc"], trial_type["id"]] }
  end

  def self.reason_codes
    codes = []
    cracked_ineffective_trial_types.each {|trial_type| codes << trial_type["reason_code"] }
    codes.uniq.sort
  end

  def self.types
    types = []
    cracked_ineffective_trial_types.each {|trial_type| types << trial_type["trial_type"] }
    types.uniq
  end
end
