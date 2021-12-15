# frozen_string_literal: true

class RepresentationOrdersController < ApplicationController
  def create
    @representation_order = LaaRepresentationOrderRecorder.call(params)
    head :accepted
  end
end
