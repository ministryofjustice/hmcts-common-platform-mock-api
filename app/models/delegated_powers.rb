# frozen_string_literal: true

class DelegatedPowers < ApplicationRecord
  validates :userId, presence: true
  validates :firstName, presence: true
  validates :lastName, presence: true

  def to_builder
    Jbuilder.new do |delegated_powers|
      delegated_powers.userId userId
      delegated_powers.firstName firstName
      delegated_powers.lastName lastName
    end
  end
end
