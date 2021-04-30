class CourtOrderSubject < ApplicationRecord
  validates :master_defendant_id, presence: true

  def to_builder
    Jbuilder.new do |court_order_subject|
      court_order_subject.masterDefendantId master_defendant_id
      court_order_subject.organisationName organisation_name
      court_order_subject.title title
      court_order_subject.firstName first_name
      court_order_subject.middleName middle_name
      court_order_subject.lastName last_name
      court_order_subject.dateOfBirth date_of_birth
      court_order_subject.addressLine1 address_line_1
      court_order_subject.pncId pnc_id
      court_order_subject.croNumber cro_number
    end
  end
end
