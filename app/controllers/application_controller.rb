class ApplicationController < ActionController::Base
  before_filter :set_slimmer_headers

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private
  def set_expiry(duration = 30.minutes)
    unless Rails.env.development?
      expires_in(duration, public: true)
    end
  end

  def set_slimmer_headers
    response.headers[Slimmer::Headers::TEMPLATE_HEADER] = "header_footer_only"
    response.headers[Slimmer::Headers::ALPHA_LABEL] = "before:.info-frontend"
  end
end
