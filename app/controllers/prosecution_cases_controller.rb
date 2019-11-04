# frozen_string_literal: true

class ProsecutionCasesController < ApplicationController
  def index
    @prosecution_cases = ProsecutionCaseSearch.call(params)
    render json: { prosecutionCases: Jbuilder.new.array!(prosecution_cases_builder) }
  end

  def laa_reference
    head :ok
  end

  private

  def prosecution_cases_builder
    @prosecution_cases.ids.map do |prosecution_case_id|
      ProsecutionCaseSummary.new(prosecution_case_id: prosecution_case_id).to_builder.attributes!
    end
  end
end
