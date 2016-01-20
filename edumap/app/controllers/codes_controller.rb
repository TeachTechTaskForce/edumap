class CodesController < ApplicationController

  def index
    @filterrific = initialize_filterrific(
      Code,
      params[:filterrific],
      :select_options => {
        sorted_by: Code.options_for_sorted_by,
        with_standard_id: Standard.options_for_select
      }
    ) or return
    @codes = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end
end
