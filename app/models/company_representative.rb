class CompanyRepresentative < ApplicationRecord
  POSITION = %w[DIRECTOR SECRETARY].freeze

  validates :id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :position, presence: true
  validates :defendants, presence: true
  validates :attendance_days, presence: true

  def to_builder
    Jbuilder.new do |company_representative|
      company_representative.id id
      company_representative.title title
      company_representative.firstName first_name
      company_representative.lastName last_name
      company_representative.position position
      company_representative.defendants defendants
      company_representative.attendanceDays attendance_days
    end
  end
end
