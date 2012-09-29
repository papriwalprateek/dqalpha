class LinksController < ApplicationController

def index
      @quest = Quest.find(params[:quest_id])
      @links = @quest.links

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @links }
      format.js
    end
  end

  # GET /qmails/1
  # GET /qmails/1.json
  def show
    @link = Link.find(params[:id])

  end

  # GET /qmails/new
  # GET /qmails/new.json
  def new
    @link = Link.new

  end

  # GET /qmails/1/edit
  def edit
  end

  # POST /qmails
  # POST /qmails.json
  def create
     @quest = Quest.find(params[:quest_id])
    @link = @quest.links.create(params[:link])
      respond_to do |format|
     
      format.html { redirect_to quest_path(@quest)}
       
        format.js
     
    end
  end

  # PUT /qmails/1
  # PUT /qmails/1.json
  
  # DELETE /qmails/1
  # DELETE /qmails/1.json
  def destroy
    @link = Link.find(params[:id])
    @quest = Quest.find(params[:quest_id])
    @link.destroy
    respond_to do |format|
       format.html { redirect_to quest_path }
       format.js 
     
      format.json { head :no_content }
     end
  end

end
