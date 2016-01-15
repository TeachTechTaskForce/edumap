class CodesController < ApplicationController

  def index
    @filterrific = initialize_filterrific(
      Code,
      params[:filterrific],
      select_options: {
        sorted_by: Code.options_for_sorted_by,
        with_standard_id: Standard.options_for_select
      },
      persistence_id: 'shared_key',
      default_filter_params: {},
      available_filters: [],
    ) or return

    @codes = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end

  # Recover from invalid param sets, e.g., when a filter refers to the
  # database id of a record that doesn’t exist any more.
  # In this case we reset filterrific and discard all filter params.
  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

end
