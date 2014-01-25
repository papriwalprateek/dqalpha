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
    wa = Wikialgo.find_by(:title => params[:a])
    wa.pages.each do |ww|
      @w<<ww
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
end