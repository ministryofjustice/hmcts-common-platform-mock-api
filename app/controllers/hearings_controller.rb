# frozen_string_literal: true

class HearingsController < ApplicationController
  def show
    @hearing = HearingFinder.call(params)

    render json: { hearing: @hearing.to_builder.attributes! }
  end
end
