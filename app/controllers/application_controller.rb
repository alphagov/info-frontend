class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private

  def set_expiry(duration = 12.hours)
    unless Rails.env.development?
      expires_in(duration, public: true)
    end
  end
end
