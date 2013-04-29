class UserSessionsController < ApplicationController
   before_filter :require_user, :only => [:destroy]
  before_filter :require_no_user, :only => [:new]
 
   # GET /user_sessions/new
  # GET /user_sessions/new.json
  def new
    @user_session = UserSession.new
    render :layout => false
 
  end
 
  # POST /user_sessions
  # POST /user_sessions.json
  def create
    @user_session = UserSession.new(params[:user_session])

    if @user_session.save
     respond_to do |format|
      format.html {  redirect_back_or  }
        format.json { render json: @user_session, status: :created, location: @user_session }
     end 
    else
        render :layout => false
    end
    
  end

   # DELETE /user_sessions/1
  # DELETE /user_sessions/1.json
  def destroy
    @user_session = UserSession.find(params[:id])
    @user_session.destroy

    respond_to do |format|
      format.html { redirect_to "/signin", notice: 'Goodbye!' }
      format.json { head :no_content }
    end
  end
end
