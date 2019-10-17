class BailStatus < ApplicationRecord
  belongs_to :custody_time_limit, optional: true

  validates :code, presence: true
  validates :description, presence: true

  def to_builder
    Jbuilder.new do |bail_status|
      bail_status.id id
      bail_status.code code
      bail_status.description description
      bail_status.custodyTimeLimit custody_time_limit.to_builder if custody_time_limit.present?
    end

  end
end
