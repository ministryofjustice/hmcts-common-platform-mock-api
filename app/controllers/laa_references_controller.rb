# frozen_string_literal: true

class LaaReferencesController < ApplicationController
  def record_reference
    @laa_reference = LaaReferenceRecorder.call(params)
    head :accepted
  end

  def record_representation_order
    @laa_reference = LaaRepresentationOrderRecorder.call(params)
    head :accepted
  end
end
