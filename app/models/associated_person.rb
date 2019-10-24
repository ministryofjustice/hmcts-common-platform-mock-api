# frozen_string_literal: true

class AssociatedPerson < ApplicationRecord
  belongs_to :person
  belongs_to :court_application_party, optional: true, inverse_of: :associated_people

  validates :person, presence: true

  def to_builder
    Jbuilder.new do |associated_person|
      associated_person.person person.to_builder
      associated_person.role role
    end
  end
end
