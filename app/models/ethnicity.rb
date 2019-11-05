# frozen_string_literal: true

class Ethnicity < ApplicationRecord
  has_one :person

  CODES = {
    'A1' => 'Indian',
    'A2' => 'Pakistani',
    'A3' => 'Bangladeshi',
    'A9' => 'Any other Asian background',
    'B1' => 'Caribbean',
    'B2' => 'African',
    'B9' => 'Any other Black background',
    'M1' => 'White and Black Caribbean',
    'M2' => 'White and Black African',
    'M3' => 'White and Asian',
    'M9' => 'Any other mixed background',
    'O1' => 'Chinese',
    'O9' => 'Any other ethnic group',
    'W1' => 'British',
    'W2' => 'Irish',
    'W9' => 'Any other White background'
  }.freeze

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
