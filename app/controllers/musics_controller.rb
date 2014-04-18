class MusicsController < ApplicationController
  layout false
 def show
     @title = "Music Repository"
     @songs = Song.where(:lyrics.ne=>nil).where(:wiki.ne=>nil).where(:meaning.ne=>nil).where(:facts.ne=>nil).limit(50).pluck(:title)
     @songs = @songs + Song.where(:lang=>"hindi").pluck(:title)
     
     if params[:search]
     @query = params[:search]
     @song = Song.find_by('title'=>/#{@query}/i)   
     
     if @song.lang=="english"
      usatoday(@song.usa_today_url)
     elsif @song.lang=="hindi"
      indiatoday(@song.india_today_url)
     end
       
     if @song.lyrics 
       puts @song.lyrics
       lyrics_extract(@song.lyrics) 
     end
     
     if @song.meaning[0]
     sm_extract(@song.meaning[0])
     end
     if @song.wiki
       music_wiki(@song.wiki)
     end
     if @song.facts
       sf_extract(@song.facts)
     end
     end 
   
     respond_to do |format|
   
      format.html 
      format.js
    end
 end
 
end
