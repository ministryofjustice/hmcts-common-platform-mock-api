# frozen_string_literal: true

class JudicialRole < ApplicationRecord
  belongs_to :judicial_role_type
  belongs_to :next_hearing, optional: true, inverse_of: :judicial_roles
  belongs_to :hearing_day, optional: true, inverse_of: :judicial_roles

  validates :judicialId, presence: true
  validates :judicial_role_type, presence: true

  def to_builder
    Jbuilder.new do |judicial_role|
      judicial_role.judicialId judicialId
      judicial_role.title title
      judicial_role.firstName firstName
      judicial_role.middleName middleName
      judicial_role.lastName lastName
      judicial_role.isDeputy isDeputy
      judicial_role.isBenchChairman isBenchChairman
      judicial_role.judicialRoleType judicial_role_type.to_builder
    end
  end
end
