class JudicialRoleType < ApplicationRecord
  validates :judiciaryType, presence: true

  def to_builder
    Jbuilder.new do |judicial_role_type|
        judicial_role_type.judicialRoleTypeId judicialRoleTypeId
        judicial_role_type.judiciaryType judiciaryType
    end
  end
end
