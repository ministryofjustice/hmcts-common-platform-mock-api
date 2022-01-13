# frozen_string_literal: true

class ProsecutionCaseConcluder < ApplicationService
  def initialize(prosecution_case_id:, publish_to: nil)
    @prosecution_case = ProsecutionCase.find(prosecution_case_id)
    @publish_to = Rails.configuration.laa_connection.key?(publish_to&.to_sym) ? publish_to : nil
  end

  def call
    prosecution_case.update!(concluded: true)
    ProsecutionConclusionPublisher.call(prosecution_case_id: prosecution_case.id, type: publish_to) if publish_to.present?
  end

private

  attr_reader :prosecution_case, :publish_to
end
