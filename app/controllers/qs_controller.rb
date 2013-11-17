class QsController < ApplicationController
#before_filter :require_user
  
def create
    @quest = Quest.find(params[:quest_id])
    @q = @quest.qs.create(params[:q])
    @qmail = @q.qmails.create(:content =>params[:qmail_content], :user_id => current_user.id)
  
    current_user.qmails << @qmail
 #       options = [:hard_wrap, :filter_html, :autolink]
  # markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new( :hard_wrap => true),
   #     :autolink => true)
  #links vm code here
 #      doc = Nokogiri::HTML(markdown.render(@qmail.content))
 #      doc.xpath('//a[@href]').each do |l|
 #       @link = @quest.links.create(:body => l['href'])
 #      end
  @q.add_questid(params[:quest_id])#tells pg_search about quest id these two lines are must after each q or qmail create  
  @qmail.add_questid(params[:quest_id])
  @q.add_qid(@q.id)
  @qmail.add_qid(@q.id)
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
    @qmails = @q.qmails
  
     if params[:qmail_id] 
      @qmail_id = params[:qmail_id]
      if params[:n_id]         
        if Notification.find(params[:n_id]).qmail_id = params[:qmail_id]            
          Notification.find(params[:n_id]).read
        end
     end
     end
     
   
 respond_to do |format|
      format.html { render "quests/_quest"}
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
