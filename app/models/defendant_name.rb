# frozen_string_literal: true

class DefendantName
  include ActiveModel::Model

  attr_reader :defendant
  attr_accessor :defendant_id

  def initialize(attributes = {})
    super
    @defendant ||= Defendant.find(attributes[:defendant_id])
  end

  def to_builder
    Jbuilder.new do |defendant_name|
      if defendant.person?
        defendant_name.firstName defendant.defendable.person.firstName
        defendant_name.middleName defendant.defendable.person.middleName
        defendant_name.lastName defendant.defendable.person.lastName
      else
        defendant_name.organisationName defendant.defendable.organisation.name
      end
    end
  end
end
