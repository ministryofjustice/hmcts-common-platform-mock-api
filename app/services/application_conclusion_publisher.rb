# frozen_string_literal: true

class ApplicationConclusionPublisher < ApplicationService
  URL = "/api/external/v1/prosecution_conclusions"

  def initialize(court_application:, type: :dev)
    @court_application = court_application
    @type = type
  end

  def call
    connection.post(URL, court_application.conclusion_payload)
  end

private

  attr_reader :court_application, :type

  def connection
    @connection ||= LaaConnector.call(**Rails.configuration.laa_connection[type])
  end
end
