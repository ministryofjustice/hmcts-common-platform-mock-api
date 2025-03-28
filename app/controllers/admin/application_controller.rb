# frozen_string_literal: true

module Admin
  class ApplicationController < ActionController::Base
    http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]

  private

    def set_env_list
      @env_options = [%w[Development dev], %w[Test test], %w[Stage stage]]
      @default_env = "dev"
    end
  end
end
