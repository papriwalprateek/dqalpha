class ApplicationController < ActionController::Base
  protect_from_forgery
helper_method :current_user,:open_html
include ApplicationHelper
  
  
  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
   def open_html(str)
   require 'rubygems'
   require 'open-uri'
   require 'nokogiri'
   
   if Rails.env.development?
    return  Nokogiri::HTML(open(str))
   else
     return Nokogiri::HTML(open(str))      
   end
 end  
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to signin_path
        return false
      end
    end

    def require_no_user
      if current_user
        flash[:notice] = "You must be logged out to access this page"
        redirect_to ''
        return false
      end
    end
   def require_vinay
    if current_user then
      redirect_to(root_path) unless current_user.name=="Vinay Raj Choudhary"
   
    else 
      redirect_to(root_path) unless current_user
   end
   end
  
  def store_location
    session[:return_to] = request.url
  end
  
  def redirect_back_or
    redirect_to(session[:return_to] || "/")
    clear_return_to
  end
  def clear_return_to
    session[:return_to] = nil
  end
  
end
