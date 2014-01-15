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
    if params[:type]
    w = Wikialgo.find_or_create_by(htag: params[:edit_algo])
    e = Element.new
    e.user_id = current_user.id
    e.value = params[:value]
    e.type = params[:type]
    w.elements << e
  end
  if @quest.id==26
    @wikialgo = Wikialgo.all.to_a()
  end
    @qs = @quest.qs.order('created_at DESC').paginate(:page => params[:page], :per_page => 25)
    if params[:page]
      @pagination = true
    end     
    if params[:partial]
      @partial = true
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
  if @quest.id==26
    @wikialgo = Wikialgo.all.to_a()
  end
  if params[:type]
    w = Wikialgo.find_or_create_by(htag: params[:edit_algo])
    e = Element.new
    e.user_id = current_user.id
    e.value = params[:value_content]
    e.type = params[:type]
    w.elements << e
  end
    @qs = @quest.qs.order('created_at DESC').paginate(:page => params[:page], :per_page => 25)
    @arr=[]
    if params[:search] && @quest.id==2
      source = open(params[:search]).read
       @disp1 = Readability::Document.new(source, :tags => %w[img p div p pre h1 h2 h3 h4 img ul a b li], :attribute => %w[href src]).content  
    end
    if params[:search] && @quest.id !=2   
     
     @query = params[:search]
     if @quest.id==26
      
     corpus_extract(@query)
     end
      vmsa =[]
      @quest.vms.each do |vm|
      vmsa<<vm.name
      end 
      
      
      @time_arr = []
      @time_arr<<Time.now      
      thread_arr =[]              
        @documents = PgSearch.multisearch(params[:search]).where(quest_id: "#{params[:id]}")
        @result_q_ids = @documents.all.map{|a| a.q_id}.uniq
        @arr<<"mailing_list"
        @time_arr<<Time.now.to_s()+"doc res"
      
      vmsa.each do |vm|
        begin
         puts vm+@query
         send(vm,@query)
           @time_arr<< Time.now.to_s()+vm
        rescue 
          puts $!.inspect
        end
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
