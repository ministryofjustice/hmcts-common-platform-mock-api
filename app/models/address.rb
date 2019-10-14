class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true, optional: true
  validates :address1, presence: true

  def to_builder
    Jbuilder.new do |address|
      address.address1 address1
      address.address2 address2
      address.address3 address3
      address.address4 address4
      address.address5 address5
      address.postcode postcode
    end
  end
end
