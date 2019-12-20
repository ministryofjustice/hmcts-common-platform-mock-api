# frozen_string_literal: true

class StatusController < ApplicationController
  skip_before_action :authenticate, only: [:index]
  def index
    render json: {}
  end
end
