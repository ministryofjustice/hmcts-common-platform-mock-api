# frozen_string_literal: true

class NotifiedPlea < ApplicationRecord
  VALUES = %w[NOTIFIED_GUILTY NOTIFIED_NOT_GUILTY NO_NOTIFICATION].freeze

  belongs_to :offence
  validates :notifiedPleaDate, presence: true
  validates :notifiedPleaValue, presence: true, inclusion: VALUES

  def to_builder
    Jbuilder.new do |notified_plea|
      notified_plea.offenceId offence_id
      notified_plea.notifiedPleaDate notifiedPleaDate.to_date
      notified_plea.notifiedPleaValue notifiedPleaValue
    end
  end
end
