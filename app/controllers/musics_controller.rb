class MusicsController < ApplicationController
  layout false
 def show
     @title = "Music Repository"
     @songs = Song.where(:lyrics.ne=>nil).where(:wiki.ne=>nil).where(:meaning.ne=>nil).limit(50).pluck(:title)
     if params[:search]
     @query = params[:search]
     @song = Song.find_by('title'=>@query)   
     if @song.lyrics 
       puts @song.lyrics
       lyrics_read(@song.lyrics) 
     end
     if @song.meaning[0]
     sm_extract(@song.meaning[0])
     end
     if @song.wiki
       music_wiki(@song.wiki)
     end
     end 
   
     respond_to do |format|
   
      format.html 
      format.js
    end
 end
 
end
