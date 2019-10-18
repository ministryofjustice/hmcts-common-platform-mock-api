# frozen_string_literal: true

class CourtIndicatedSentence < ApplicationRecord
  validates :courtIndicatedSentenceTypeId, presence: true
  validates :courtIndicatedSentenceDescription, presence: true

  def to_builder
    Jbuilder.new do |court_indicated_sentence|
      court_indicated_sentence.courtIndicatedSentenceTypeId courtIndicatedSentenceTypeId
      court_indicated_sentence.courtIndicatedSentenceDescription courtIndicatedSentenceDescription
    end
  end
end
