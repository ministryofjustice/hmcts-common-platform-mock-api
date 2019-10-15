class NextHearingOffence < ApplicationRecord

  belongs_to :next_hearing_defendant, optional: true, inverse_of: :next_hearing_offences

  def to_builder
    Jbuilder.new do |next_hearing_offence|
      next_hearing_offence.id id
    end
  end
end
