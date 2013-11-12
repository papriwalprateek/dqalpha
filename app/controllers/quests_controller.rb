class QuestsController < ApplicationController
 # before_filter :require_user
  
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
    @arr=[]
    if params[:search]     
     @query = params[:search]
      @time_arr = []
      @time_arr<<Time.now      
      @documents = PgSearch.multisearch(params[:search]).where(quest_id: "#{params[:id]}")
      @arr<<"mailing_list"
      thread_arr =[]
      @time_arr<<Time.now.to_s()
      @quest.vms.each do |vm|
      #vm = @quest.vms.last
      thread_arr<<Thread.new{         
        begin
           send(vm.name,@query)
           @time_arr<< Time.now.to_s()+vm.name
        rescue
        end
      }
      end 
      thread_arr.each do |t|
        t.join
      @time_arr<< Time.now.to_s()     
      end
      @time_arr<< Time.now.to_s()+"end"
     
     @scilab_results = @arr.include?("description")
      @bugzilla_results = @arr.include?("bugs")
      @so_results = @arr.include?("qna")     
    end 

     respond_to do |format|
   
      format.html {render "_quest" }# show.html.erb
      #format.json { render :json => @quest }
      format.js
    end
  end
end
