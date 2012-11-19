class QsController < ApplicationController
before_filter :require_user
  
def create
    @quest = Quest.find(params[:quest_id])
    @q = @quest.qs.create(params[:q])
    
  respond_to do |format|
     
        format.html { redirect_to quest_path(@quest)}
        format.js
  end
  end
  def index
    
  end
  def show
    @q = Q.find(params[:id])
    @quest = @q.quest
    if params[:add_user] 
      @user = User.find_by_name(params[:add_user])
      @quest.users << @user
    end
 respond_to do |format|
      format.html {render "_q"}# show.html.erb
      format.json { render :json => @q }
      format.js
    end
  end
def destroy
    @q = Q.find(params[:id])
    @q.destroy

    respond_to do |format|
      format.html { redirect_to qs_url }
      format.json { head :no_content }
    end
  end

end
