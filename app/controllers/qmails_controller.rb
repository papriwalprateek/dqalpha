class QmailsController < ApplicationController
  # GET /qmails
  # GET /qmails.json
  #require 'mashup'
  #  include Mashup
  def index
     @qmails = Qmail.where("q_id = ? and created_at > ?", params[:q_id], Time.at(params[:after].to_i + 1))

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @qmails }
      format.js
    end
  end

  # GET /qmails/1
  # GET /qmails/1.json
  def show
    @qmail = Qmail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @qmail }
    end
  end

  # GET /qmails/new
  # GET /qmails/new.json
  def new
    @qmail = Qmail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @qmail }
    end
  end

  # GET /qmails/1/edit
  def edit
    @qmail = Qmail.find(params[:id])
  end

  # POST /qmails
  # POST /qmails.json
  def create
     @q = Q.find(params[:q_id])
    
   #temp_content = a(params[:qmail_content])
    @qmail = @q.qmails.create(:content =>params[:qmail_content],:user_id => current_user.id)
    @quest = @q.quest
    current_user.qmails << @qmail

  #links vm code here
 #      doc = Nokogiri::HTML(markdown.render(@qmail.content))
 #      doc.xpath('//a[@href]').each do |l|
 #       @link = @quest.links.create(:body => l['href'])
 #      end
   respond_to do |format|
     
        format.html { redirect_to q_path(@q)}
        format.js     
    end
 #   new_qmail_notify(@qmail)
  end
 
  # PUT /qmails/1
  # PUT /qmails/1.json
  def update
    @qmail = Qmail.find(params[:id])

    respond_to do |format|
      if @qmail.update_attributes(params[:qmail])
        format.html { redirect_to @qmail, notice: 'Qmail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @qmail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /qmails/1
  # DELETE /qmails/1.json
  def destroy
    @qmail = Qmail.find(params[:id])
    @qmail.destroy
    @q = @qmail.q
    @quest = @q.quest
    
    respond_to do |format|
      format.html { redirect_to q_path(@q) }
      format.js {render action: "create" }
      
      format.json { head :no_content }
    end
  end
end