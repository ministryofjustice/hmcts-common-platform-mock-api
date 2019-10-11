class Ethnicity < ApplicationRecord
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
