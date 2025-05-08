# frozen_string_literal: true

module Admin
  class ApplicationController < ActionController::Base
    http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]

    before_action :instantiate_breadcrumbs

  private

    def set_env_list
      @env_options = [%w[Development dev], %w[Test test], %w[Stage stage]]
      @default_env = "dev"
    end

    Breadcrumb = Data.define(:path, :text)

    def instantiate_breadcrumbs
      @breadcrumbs = []
    end

    def add_breadcrumb(text, path = nil)
      @breadcrumbs << Breadcrumb.new(text:, path:)
    end
  end
end
