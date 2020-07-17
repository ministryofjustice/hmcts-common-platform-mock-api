# frozen_string_literal: true

class HearingType < ApplicationRecord
  validates :description, presence: true

  def to_builder
    Jbuilder.new do |hearing_type|
      hearing_type.id id
      hearing_type.description description
    end
  end
end
