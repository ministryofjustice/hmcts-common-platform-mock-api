# frozen_string_literal: true

class CustodyTimeLimit < ApplicationRecord
  validates :timeLimit, presence: true
  validates :daysSpent, presence: true

  def to_builder
    Jbuilder.new do |custody_time_limit|
      custody_time_limit.timeLimit timeLimit.to_date
      custody_time_limit.daysSpent daysSpent
    end
  end
end
