class ReportingRestriction < ApplicationRecord
  validates :id, presence: true
  validates :label, presence: true

  def to_builder
    Jbuilder.new do |reporting_restriction|
      reporting_restriction.id id
      reporting_restriction.judicialResultId judicial_result_id
      reporting_restriction.label label
      reporting_restriction.orderedDate ordered_date
    end
  end
end
