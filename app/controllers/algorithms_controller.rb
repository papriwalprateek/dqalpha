class AlgorithmsController < ApplicationController
  layout false
 def show
    @wikialgo = Wikialgo.all.to_a()
    @arr=[]
    @title = "Algorithms Repository"
    if params[:search]
     @query = params[:search]
     #corpus_extract(@query)
     
      vmsa =["algorithm_webpages"]
      
      vmsa.each do |vm|
         puts vm+@query
        send(vm,@query)
        
      end   
    end 
     respond_to do |format|
   
      format.html 
      format.js
    end
  end
def rhodes
  @w = []
  if params[:a] 
    wb = Wikialgo.find_by(:title => params[:a])
    wa = {"pages"=> [] }
    wb.pages.desc(:prank).each do |ww|
      @w<<ww
      wa["pages"]<<ww
    end
  end
   respond_to do |format|
   
      format.html
      format.json {render json: wa } 
    end
end
 def rhodesread
    webpages_read(params[:ad]) 
    wa = {"title"=>@y_title,"content"=>@y}
    respond_to do |format|
      format.html      
      format.json {render json: wa } 
     end
  end
   def rank
    if params[:type]
    q = Wikialgo.find_by("pages.link"=> params[:link]).pages.find_by("link"=>params[:link])
    q.prank = params[:type]
    q.save
    end
    p = Wikialgo.find_by("pages.prank"=>0).pages.find_by("prank"=>0)
    webpages_read(p.link) 
    @link = p.link
    respond_to do |format|
      format.html      
     end
  end
  def categorylist
    w = Wikialgo.where(:category=>params["cat"]).pluck(:title)
    respond_to do |format|
      format.json {render json: w}
    end
  end
end