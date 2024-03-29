# frozen_string_literal: true

class ProsecutionCasesController < ApplicationController
  def index
    @prosecution_cases = ProsecutionCaseSearch.call(params)

    headers["Content-Type"] = "application/vnd.unifiedsearch.query.laa.cases+json"
    render json: prosecution_cases_response
  end

private

  def prosecution_cases_response
    { totalResults: @prosecution_cases.size, cases: prosecution_cases_builder }
  end

  def prosecution_cases_builder
    @prosecution_cases.ids.map do |prosecution_case_id|
      ProsecutionCaseSummary.new(prosecution_case_id:).to_builder.attributes!
    end
  end
end
