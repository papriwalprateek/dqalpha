class PagesController < ApplicationController
  def about
 
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
    respond_to do |format|
      format.js { render "layouts/wiki"  }
     end
  end
def so
    @content = so_content(params[:ad])
    respond_to do |format|
      format.js { render "layouts/so"  }
     end
  end

  def contact
  @title = "contact"
  end
end
