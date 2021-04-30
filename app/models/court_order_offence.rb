class CourtOrderOffence < ApplicationRecord
  belongs_to :offence
  belongs_to :prosecution_case_identifier

  validates :offence, presence: true
  validates :prosecution_case_id, presence: true
  validates :prosecution_case_identifier, presence: true

  def to_builder
    Jbuilder.new do |court_order_offence|
      court_order_offence.offence offence.to_builder
      court_order_offence.prosecutionCaseId prosecution_case_id
      court_order_offence.prosecutionCaseIdentifier prosecution_case_identifier.to_builder
    end
  end
end
