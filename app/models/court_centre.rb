# frozen_string_literal: true

class CourtCentre
  include ActiveModel::Model

  attr_accessor :data

  def initialize(data)
    @data = HashWithIndifferentAccess.new(data || {})
  end

  def self.all
    court_centre_data.map { |cc| new(cc) }
  end

  def self.find_by(id:)
    new(court_centre_data.find { |cc| cc["id"] == id })
  end

  def id
    data["id"]
  end

  def name
    data["oucode_l3_name"]
  end

  def welsh_name
    data["oucode_l3_welsh_name"]
  end

  def address1
    data["address1"]
  end

  def address2
    data["address2"]
  end

  def address3
    data["address3"]
  end

  def address4
    data["address4"]
  end

  def address5
    data["address5"]
  end

  def postcode
    data["postcode"]
  end

  def to_builder
    Jbuilder.new do |court_centre|
      court_centre.id id
      court_centre.name name
      court_centre.welshName welsh_name
      court_centre.address address.to_builder if address.present?
    end
  end

private

  def address
    return if address1.blank?

    @address ||= Address.new(
      address1:,
      address2:,
      address3:,
      address4:,
      address5:,
      postcode:,
    )
  end

  def self.court_centre_data
    YAML.load_file("./lib/data/court_centres_sample.yml")
  end

  private_class_method :court_centre_data
  private_class_method :new
end
