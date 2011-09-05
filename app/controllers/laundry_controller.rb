class LaundryController < ApplicationController
  before_filter :load_laundry_thing, :only => [:show, :signal]
  before_filter :require_post, :only => [:signal]
  
  def list
    @laundry_things = LaundryThing.all
  end

  def show 
  end

  def signal
    debugger if @laundry_thing.nil?
    @action = @laundry_thing.record_action params[:audited_action]
    if @action.nil?
      flash[:alert] = "Action Not Found"
      render_404
    end
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
