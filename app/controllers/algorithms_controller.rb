class AlgorithmsController < ApplicationController
  layout false
 def show
    @wikialgo = Wikialgo.all.pluck(:title)
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
    wp = Wikialgo.find_by("pages.prank"=>0)
    if wp
    p = Wikialgo.find_by("pages.prank"=>0).pages.find_by("prank"=>0)
    webpages_read(p.link) 
    @link = p.link
    else
    @aneg = []
    @a1 =[]
    @a2= []
    @a3= []
    @a4= []
    @a5= []
    Wikialgo.each do |w|
      w.pages.each do |pt|
       case pt.prank
        when -1
          @aneg<<pt
        when 1
          @a1 << pt
        when 2
          @a2 << pt
        when 3
          @a3 << pt
        when 4
          @a4 << pt
        when 5
          @a5 << pt
        else
        puts "You gave me #{a} -- I have no idea what to do with that."
       end
      end
    end
    end
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