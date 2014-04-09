class MusicsController < ApplicationController
  layout false
 def show
     @title = "Music Repository"
     @songs = Song.all.pluck(:title)
     if params[:search]
     @query = params[:search]
     @song = Song.find_by('title'=>@query)
     lyrics_read(@song.lyrics)  
     end 
     respond_to do |format|
   
      format.html 
      format.js
    end
 end
 
end
