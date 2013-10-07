class QuestsController < ApplicationController
  before_filter :require_user
  
  def create
    @user = current_user
    @quest = @user.quests.create(params[:quest])
 
    respond_to do |format|
   
    format.html {   redirect_to quest_path(@quest)}# show.html.erb
    format.js
    end
 
  end
  def index
    @inv = @quest.involvements.where("user_id=?",current_user)
    @inv[0].destroy
   respond_to do |format|
         format.html {render "_quest" }# show.html.erb
      format.json { render :json => @quest }
      format.js   
    
  end
  end
  
  def show
    @quest = Quest.find(params[:id])
    @qs = @quest.qs
    if params[:search]     
      @documents = PgSearch.multisearch(params[:search]).where(quest_id: "#{params[:id]}")
      begin
      @scilab_results = scilab_help(params[:search])
      rescue
      end
    end 
    if params[:add_user]     
      invite(current_user.name,current_user.id,@quest.id,@quest.title,params[:add_user])
    end
     respond_to do |format|
   
      format.html {render "_quest" }# show.html.erb
      format.json { render :json => @quest }
      format.js
    end
  end
  def add_user
  
  end
   def n
    @inv = @quest.involvements.where("user_id=?",current_user)
    @inv[0].destroy
   respond_to do |format|
         format.html {render "_quest" }# show.html.erb
      format.json { render :json => @quest }
      format.js   
    
  end

  end
 def search
    @quest = Quest.find(params[:id])
    @qs = @quest.qs
    if params[:search]     
      @documents = PgSearch.multisearch(params[:search]).where(quest_id: "#{params[:id]}")
      begin
      @scilab_results = scilab_help(params[:search])
      rescue
      end
      begin
      @so_results = so_search(params[:search])
      rescue
      end
      begin
      @bugzilla_results = bugzilla_search(params[:search])
      rescue
      end
    end 

     respond_to do |format|
   
      #format.html {render "_quest" }# show.html.erb
      #format.json { render :json => @quest }
      format.js
    end
  end
end
