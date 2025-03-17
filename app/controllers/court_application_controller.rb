class CourtApplicationController < ApplicationController
  def index
    @court_application = CourtApplicationSearch.call(params)

    render json: court_application_response
  end

private

  def court_application_response
    return {} if @court_application.blank?

    CourtApplicationSummary.new({ court_application_id: @court_application.id }).to_builder.attributes!
  end
end
