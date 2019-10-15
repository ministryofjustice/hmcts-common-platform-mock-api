class NextHearingOffence < ApplicationRecord

  def to_builder
    Jbuilder.new do |next_hearing_offence|
      next_hearing_offence.id id
    end
  end
end
