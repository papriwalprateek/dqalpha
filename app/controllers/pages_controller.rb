class PagesController < ApplicationController
 before_filter :require_user, :only => [:home] 
  def about
  render :layout => false
@title = "about"

  end
 def google885d2aab83a9c566
 render :layout => false
@title = "google_authentication"

  end

  def search
  @title = "search"  end

  def home
    @unread_notifications = current_user.notifications.where(:has_read=>false).order("created_at DESC")
    respond_to do |format|
      format.html # new.html.erb
      format.js
    end

 #asd
  end
def wik
    @content = wiki_content(params[:ad])
    @query = params[:ad]
    respond_to do |format|
      format.js { render "layouts/wiki"  }
     end
  end

def scilab
    @content = scilab_help(params[:ad])
        @query_sc = params[:ad]
    respond_to do |format|
      format.js { render "layouts/scilab"  }
     end
  end
  def bugzilla
    @content = bugzilla_help(params[:ad])
        @query_sc = params[:ad]
    respond_to do |format|
      format.js { render "layouts/bugzilla"  }
     end
  end
def so
    @content = so_content(params[:ad])
        @query_so = params[:ad]
    respond_to do |format|
      format.js { render "layouts/so"  }
     end
  end
def read_notification
    @notification = Notification.find(params[:n_id])
    @notification.read
    respond_to do |format|
      format.js 
    end

end
def clear_notification
    @notification = Notification.find(params[:n_id])
    @notification.read
    
end
def leave_quest
   Involvement.find(params[:i_id]).destroy
   respond_to do |format|
      format.js 
    end  
end
def join_quest
      @user = User.find(params[:join_quest_user_id])
      @quest = Quest.find(params[:join_quest_quest_id])
      @quest.users << @user
respond_to do |format|
      format.js 
    end
end
  def contact
  @title = "contact"
  end
    def team
  @title = "team"
  render :layout => false
  end
  def blogs
  @title = "blogs"
  render :layout => false
  end
   def notifications
  @title = "notifications"
  respond_to do |format|
      format.html{render "pages/_notifications"}
      format.js { render "pages/notifications"  }
     end
  end
  
  def scilab_extract
  @title = "scilab_extract"
  @d = params[:urls]
  if @d
    @ds = @d[:a].split(",")
    @ds.each do |url|
     url = url.delete("[']")
     scilab_extract_it(url) 
     end
  end
      respond_to do |format|
      format.html
     end
  end
end
