# frozen_string_literal: true

class HearingResulter < ApplicationService
  def initialize(hearing_id:, publish_to: nil)
    @hearing = Hearing.find(hearing_id)
    @publish_to = Rails.configuration.laa_connection.key?(publish_to&.to_sym) ? publish_to : nil
  end

  def call
    hearing.update(resulted: true)
    HearingResultedPublisher.call(hearing_id: hearing.id, type: publish_to) if publish_to.present?
    hearing.resulted?
  end

  private

  attr_reader :hearing, :publish_to
end
