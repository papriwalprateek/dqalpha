class PagesController < ApplicationController
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
 @title = params[:q] 
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
  def contact
  @title = "contact"
  end
    def team
  @title = "team"
  render :layout => false
  end
   def notifications
  @title = "notifications"
  respond_to do |format|
      format.html{render "pages/_notifications"}
      format.js { render "pages/notifications"  }
     end
  end
end
