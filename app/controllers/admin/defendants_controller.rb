module Admin
  class DefendantsController < Admin::ApplicationController
    def show
      @defendant = Defendant.find(params[:id])
    end
  end
end
