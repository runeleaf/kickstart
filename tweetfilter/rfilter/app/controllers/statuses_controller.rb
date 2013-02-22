class StatusesController < ApplicationController
  # GET /statuses
  # GET /statuses.xml
  def index
    @statuses = Status.paginate :per_page => 100, :page => params[:page], :order => "created_at desc"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statuses }
    end
  end

  def filter
    Status.search
    render :text => 'tracking and filtering finish.'
  end

end
