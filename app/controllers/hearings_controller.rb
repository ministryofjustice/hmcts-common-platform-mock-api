# frozen_string_literal: true

class HearingsController < ApplicationController
  def show
    @hearing = HearingFinder.call(params)

    render json: hearing_response
  end

private

  def hearing_response
    return {} if @hearing.blank?

    @hearing.resulted_response
  end
end
