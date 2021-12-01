# frozen_string_literal: true

class CourtCentre
  include ActiveModel::Model

  attr_accessor :id

  def name
    csv_row["oucode_l3_name"]
  end

  def to_builder
    Jbuilder.new do |court_centre|
      court_centre.id id
      court_centre.name name
      court_centre.welshName csv_row["oucode_l3_welsh_name"]
      court_centre.roomId id # Using CourtCentre while we manage to get a list of rooms
      court_centre.roomName csv_row["oucode_l3_name"] # Using CourtCentre while we manage to get a list of rooms
      court_centre.welshRoomName csv_row["oucode_l3_welsh_name"] # Using CourtCentre while we manage to get a list of rooms
      court_centre.address address.to_builder if address.present?
    end
  end

private

  def csv_row
    @csv_row ||= courts.find { |court| court["id"] == id }
  end

  def address
    return if csv_row["address1"].blank?

    @address ||= Address.new(
      address1: csv_row["address1"],
      address2: csv_row["address2"],
      address3: csv_row["address3"],
      address4: csv_row["address4"],
      address5: csv_row["address5"],
      postcode: csv_row["postcode"],
    )
  end

  def courts
    YAML.load_file("./lib/data/court_centres_sample.yml")
  end
end
