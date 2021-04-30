class CourtOrder < ApplicationRecord
  include BuilderMappable
  include CourtCentreRelatable

  has_many :court_order_offences

  validates :id, presence: true
  validates :judicial_result_type_id, presence: true
  validates :label, presence: true
  validates :order_date, presence: true
  validates :start_date, presence: true
  validates :ordering_hearing_id, presence: true
  validates :court_order_offences, presence: true
  validates :court_centre_id, presence: true

  def to_builder
    Jbuilder.new do |court_order|
      court_order.id id
      court_order.defendantIds defendant_ids
      court_order.masterDefendantId master_defendant_id
      court_order.judicialResultTypeId judicial_result_type_id
      court_order.label label
      court_order.orderDate order_date
      court_order.startDate start_date
      court_order.endDate end_date
      court_order.orderingCourt court_centre.to_builder
      court_order.orderingHearingId ordering_hearing_id
      court_order.isSJPOrder is_sjp_order
      court_order.canBeSubjectOfBreachProceedings can_be_subject_of_breach_proceedings
      court_order.canBeSubjectOfVariationProceedings can_be_subject_of_variation_proceedings
      court_order.courtOrderOffences array_builder(court_order_offences)
    end
  end
end
