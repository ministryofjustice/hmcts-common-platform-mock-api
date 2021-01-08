# frozen_string_literal: true

module Admin
  class ApplicationController < ActionController::Base
    http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]
  end
end
