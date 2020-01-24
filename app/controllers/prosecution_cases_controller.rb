# frozen_string_literal: true

class ProsecutionCasesController < ApplicationController
  def index
    @prosecution_cases = ProsecutionCaseSearch.call(params)

    render json: prosecution_cases_response
  end

  private

  def prosecution_cases_response
    return {} if @prosecution_cases.empty?

    prosecution_cases_builder
  end

  def prosecution_cases_builder
    @prosecution_cases.ids.map do |prosecution_case_id|
      ProsecutionCaseSummary.new(prosecution_case_id: prosecution_case_id).to_builder.attributes!
    end
  end

  def authenticate
    authenticated = ActiveSupport::SecurityUtils.secure_compare(
      request.headers.fetch('LAASearchCase-Subscription-Key', ''),
      ENV.fetch('SHARED_SECRET_KEY_SEARCH_PROSECUTION_CASE')
    )

    head :unauthorized unless authenticated
  end
end
