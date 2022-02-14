# frozen_string_literal: true

class ProsecutionConclusionPublisher < ApplicationService
  URL = "/api/external/v1/prosecution_conclusions"

  def initialize(prosecution_case_id:, type: :dev)
    @prosecution_case = ProsecutionCase.find(prosecution_case_id)
    @type = type
  end

  def call
    connection.post(URL, prosecution_case.conclusion_payload)
  end

private

  attr_reader :prosecution_case, :type

  def connection
    @connection ||= LaaConnector.call(**Rails.configuration.laa_connection[type])
  end
end
