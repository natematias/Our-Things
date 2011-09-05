# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :laundry_path
  helper_method :signal_path

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  def render_404 status = 404
    render :file => "#{Rails.public_path}/404.html", :status => status, :content_type => Mime::HTML
  end

  def laundry_path laundry_thing
    "/laundry/show/#{laundry_thing.id}"
  end

  def signal_path laundry_thing
    "/laundry/signal/#{laundry_thing.id}"
  end

end
