# frozen_string_literal: true

class HearingResultedPublisher < ApplicationService
  URL = '/api/external/v1/hearings'

  def initialize(hearing_id:, type: :dev)
    @hearing = Hearing.where(resulted: true).find(hearing_id)
    @type = type
  end

  def call
    connection.post(URL, hearing.resulted_response)
  end

  private

  attr_reader :hearing, :type

  def connection
    @connection ||= LaaConnector.call(**Rails.configuration.laa_connection[type])
  end
end
