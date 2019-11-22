# frozen_string_literal: true

class LaaReferencesController < ApplicationController
  def record_reference
    @laa_reference = LaaReferenceRecorder.call(params)
    head newly_created_resource? ? :created : :no_content
  end

  def record_representation_order
    @laa_reference = LaaRepresentationOrderRecorder.call(params)
    head newly_created_resource? ? :created : :no_content
  end

  private

  def newly_created_resource?
    @laa_reference.previous_changes[:id].present?
  end
end