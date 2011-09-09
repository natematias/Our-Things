class LaundryController < ApplicationController
  before_filter :load_laundry_thing, :only => [:show, :signal, :calendar]
  before_filter :require_post, :only => [:signal]
  layout 'our_things'
  
  def index
    @laundry_things = LaundryThing.all
  end

  def show 
  end

  def calendar
    @audited_actions = @laundry_thing.audited_actions
    respond_to do |format|
      format.html { render :layout => nil}
      format.ics {render :layout => nil }
      format.rss {render :layout => nil}
    end
  end

  def signal
    @action = @laundry_thing.record_action params[:audited_action]
    if @action.nil?
      flash[:alert] = "Action Not Found"
    else
      flash[:alert] = "Laundry Status Updated"
    end
    redirect_to laundry_path(@laundry_thing)
  end

  protected

  def load_laundry_thing
    @laundry_thing = LaundryThing.find_by_id(params[:id])
    if @laundry_thing.nil?
      flash[:alert] = "Laundry Item Not Found"
      render_404
    end
  end

  def require_post
    if request.method != :post
      flash[:alert] = "There was a problem with your web request"
      render_404 :method_not_allowed
    end
  end
end
