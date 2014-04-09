class MovieController < ApplicationController
  layout false
 def show
     @title = "Movie Repository"
     respond_to do |format|
   
      format.html 
      format.js
    end
 end
 
end
