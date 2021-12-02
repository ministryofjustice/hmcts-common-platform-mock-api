# frozen_string_literal: true

class CourtCentre
  attr_accessor :id, :name, :welsh_name,
                :address1, :address2, :address3,
                :address4, :address5, :postcode

  def initialize(id:, name:, welsh_name:, address1:, address2:, address3:, address4:, address5:, postcode:)
    @id = id
    @name = name
    @welsh_name = welsh_name
    @address1 = address1
    @address2 = address2
    @address3 = address3
    @address4 = address4
    @address5 = address5
    @postcode = postcode
  end

  def self.all
    YAML.load_file("./lib/data/court_centres_sample.yml").map do |court_centre_data|
      new(
        id: court_centre_data["id"],
        name: court_centre_data["oucode_l3_name"],
        welsh_name: court_centre_data["welshName"],
        address1: court_centre_data["address1"],
        address2: court_centre_data["address2"],
        address3: court_centre_data["address3"],
        address4: court_centre_data["address4"],
        address5: court_centre_data["address5"],
        postcode: court_centre_data["postcode"],
      )
    end
  end

  def self.find_by(id:)
    all.find { |cc| cc.id == id }
  end

  def to_builder
    Jbuilder.new do |court_centre|
      court_centre.id id
      court_centre.name name
      court_centre.welshName welsh_name
      court_centre.address address.to_builder
    end
  end

private

  def address
    Address.new(
      address1: address1,
      address2: address2,
      address3: address3,
      address4: address4,
      address5: address5,
      postcode: postcode,
    )
  end
end
