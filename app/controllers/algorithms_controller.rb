class AlgorithmsController < ApplicationController
  layout false
 def show
    @wikialgo = Wikialgo.all.to_a()
    @arr=[]
    @title = "Algorithms Repository"
    if params[:search]
     @query = params[:search]
     corpus_extract(@query)
     
      vmsa =["algorithm_wiki","algorithm_geeks","algorithm_git","algorithm_rosetta"]
      
      vmsa.each do |vm|
        begin
         puts vm+@query
         send(vm,@query)
        rescue 
        end
      end   
    end 
     respond_to do |format|
   
      format.html 
      format.js
    end
  end

end