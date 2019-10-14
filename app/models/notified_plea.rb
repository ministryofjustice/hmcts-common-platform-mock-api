class NotifiedPlea < ApplicationRecord
  VALUES = %w(NOTIFIED_GUILTY NOTIFIED_NOT_GUILTY NO_NOTIFICATION)

  validates :offenceId, presence: true
  validates :notifiedPleaDate, presence: true
  validates :notifiedPleaValue, presence: true, inclusion: VALUES

  def to_builder
    Jbuilder.new do |notified_plea|
      notified_plea.offenceId offenceId
      notified_plea.notifiedPleaDate notifiedPleaDate.to_date
      notified_plea.notifiedPleaValue notifiedPleaValue
    end
  end
end
