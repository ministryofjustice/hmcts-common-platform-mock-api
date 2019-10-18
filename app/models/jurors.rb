# frozen_string_literal: true

class Jurors < ApplicationRecord
  validates :numberOfJurors, presence: true
  validates :numberOfSplitJurors, presence: true
  validates :unanimous, inclusion: [true, false]

  def to_builder
    Jbuilder.new do |jurors|
      jurors.numberOfJurors numberOfJurors
      jurors.numberOfSplitJurors numberOfSplitJurors
      jurors.unanimous unanimous
    end
  end
end
