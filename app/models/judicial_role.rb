# frozen_string_literal: true

class JudicialRole < ApplicationRecord
  belongs_to :judicial_role_type
  belongs_to :next_hearing, optional: true, inverse_of: :judicial_roles

  validates :judicialId, presence: true
  validates :judicial_role_type, presence: true

  def to_builder
    Jbuilder.new do |judicial_role|
      judicial_role.judicialId judicialId
      judicial_role.judicialRoleType judicial_role_type.to_builder
    end
  end
end
