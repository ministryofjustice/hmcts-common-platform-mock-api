class DefendantJudicialResult < ApplicationRecord
  belongs_to :judicial_result

  validates :master_defendant_id, presence: true
  validates :judicial_result, presence: true

  def to_builder
    Jbuilder.new do |defendant_judicial_result|
      defendant_judicial_result.masterDefendantId master_defendant_id
      defendant_judicial_result.judicialResult judicial_result.to_builder
    end
  end
end
