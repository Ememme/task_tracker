# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private
   def authenticate_user
    redirect_to sign_up_path unless current_user
  end
   def current_user
    @current_user ||= User.find_by(id: session[:current_user_id])
  end
end
