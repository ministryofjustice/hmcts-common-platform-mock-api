# frozen_string_literal: true

class HearingType < ApplicationRecord
  validates :description, presence: true
  validates :code, presence: true

  def to_builder
    Jbuilder.new do |hearing_type|
      hearing_type.id id
      hearing_type.description description
      hearing_type.code code
    end
  end
end
