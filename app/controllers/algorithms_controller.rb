class AlgorithmsController < ApplicationController
  layout false
 def show
    @categories = ["Sequence sorting","Dynamic Programming","Graph algorithms","Strings and pattern matching","Tree (data structure)", "Combinatorial algorithms", "Optimization algorithms","Machine learning","Statistics"]
    @wikialgo = Wikialgo.all.pluck(:title)
    @arr=[]
    @title = "Algorithms Repository"
    if params[:search]
     @query = params[:search]
      vmsa =["algorithm_webpages","algorithm_rosetta","corpus_extract"]
      
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
    wa = {"desc"=>[],"pages"=> [],"videos"=>[] }
    wb.pages.where(:prank.gt=>3,:prank.lt=>6).desc(:prank).each do |ww|
      @w<<ww
      wa["pages"]<<ww
    end
    wb.descriptions.each do |ww|
      wa["desc"]<<ww
    end
    wb.pages.where(:prank=>6).each do |ww|
      wa["videos"]<<ww
    end
  end
   respond_to do |format|
   
      format.html
      format.json {render json: wa } 
    end
end
 def rhodesread
    @mobile = true
    a = (request.original_url.split("/rhodesread?ad=")[1])||(request.original_url.split("/rhodesread.json?ad=")[1])
    webpages_read(a)  
    wa = {"title"=>@y_title,"content"=>@y}
    respond_to do |format|
      format.html      
      format.json {render json: wa } 
     end
  end
  def ranked
    respond_to do |format|
      format.html      
     end
  end
   def rank
    if params[:type]
    q = Wikialgo.find_by("pages.prank"=> 0).pages.find_by("link"=>params[:link])
    q.prank = params[:type]
    q.save
    end
    begin
    wp = Wikialgo.find_by("pages.prank"=>0)
    rescue
    wp = nil
    end
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