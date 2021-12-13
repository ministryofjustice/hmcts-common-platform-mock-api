# frozen_string_literal: true

class LaaReferencesController < ApplicationController
  def create
    @laa_reference = LaaReferenceRecorder.call(params)
    head :accepted
  end
end
