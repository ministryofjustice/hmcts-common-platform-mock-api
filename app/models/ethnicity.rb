# frozen_string_literal: true

class Ethnicity < ApplicationRecord
  has_one :person

  def to_builder
    Jbuilder.new do |ethnicity|
      ethnicity.observedEthnicityId observedEthnicityId
      ethnicity.observedEthnicityCode observedEthnicityCode
      ethnicity.observedEthnicityDescription observedEthnicityDescription
      ethnicity.selfDefinedEthnicityId selfDefinedEthnicityId
      ethnicity.selfDefinedEthnicityCode selfDefinedEthnicityCode
      ethnicity.selfDefinedEthnicityDescription selfDefinedEthnicityDescription
    end
  end
end
