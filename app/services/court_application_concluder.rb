# frozen_string_literal: true

class CourtApplicationConcluder < ApplicationService
  def initialize(court_application_id:, publish_to: nil)
    @court_application = CourtApplication.find(court_application_id)
    @publish_to = Rails.configuration.laa_connection.key?(publish_to&.to_sym) ? publish_to : nil
  end

  def call
    court_application.defendant.prosecution_case.update!(concluded: true)
    ApplicationConclusionPublisher.call(court_application:, type: publish_to) if publish_to.present?
  end

private

  attr_reader :court_application, :publish_to
end
