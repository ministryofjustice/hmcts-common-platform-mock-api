# frozen_string_literal: true

class AssociatedPerson < ApplicationRecord
  belongs_to :person

  validates :person, presence: true

  def to_builder
    Jbuilder.new do |associated_person|
      associated_person.person person.to_builder
      associated_person.role role
    end
  end
end
