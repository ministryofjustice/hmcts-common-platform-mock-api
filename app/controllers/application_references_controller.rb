class ApplicationReferencesController < ApplicationController
  def create
    ApplicationReferenceRecorder.call(params)
    head :accepted
  end
end
