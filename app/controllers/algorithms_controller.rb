class AlgorithmsController < ApplicationController
  layout false
 def show
    @wikialgo = Wikialgo.all.to_a()
    @arr=[]
    @title = "Algorithms Repository"
    if params[:search]
     @query = params[:search]
     #corpus_extract(@query)
     
      vmsa =["algorithm_geeks","algorithm_wiki","algorithm_rosetta","algorithm_youtube"]
      
      vmsa.each do |vm|
         puts vm+@query
         begin
         send(vm,@query)
        rescue
        puts "------------------------rescued error here "
        end
      end   
    end 
     respond_to do |format|
   
      format.html 
      format.js
    end
  end

end