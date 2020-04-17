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

  private

  def authenticate
    send("authenticate_#{action_name}")
  end

  def authenticate_record_reference
    authenticated = ActiveSupport::SecurityUtils.secure_compare(
      request.headers.fetch('Ocp-Apim-Subscription-Key', ''),
      ENV.fetch('SHARED_SECRET_KEY_LAA_REFERENCE')
    )

    head :unauthorized unless authenticated
  end

  def authenticate_record_representation_order
    authenticated = ActiveSupport::SecurityUtils.secure_compare(
      request.headers.fetch('Ocp-Apim-Subscription-Key', ''),
      ENV.fetch('SHARED_SECRET_KEY_REPRESENTATION_ORDER')
    )

    head :unauthorized unless authenticated
  end
end
