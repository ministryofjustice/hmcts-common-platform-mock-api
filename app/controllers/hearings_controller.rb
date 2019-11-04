# frozen_string_literal: true

class HearingsController < ApplicationController
  def show
    @hearing = Hearing.find(params[:id])
    render json: { hearing: @hearing.to_builder.attributes! }
  end
end
