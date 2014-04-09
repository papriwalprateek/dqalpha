class MusicController < ApplicationController
  layout false
 def show
     @title = "Music Repository"
     respond_to do |format|
   
      format.html 
      format.js
    end
 end
 
end
