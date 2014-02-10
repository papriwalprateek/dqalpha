@pt =[]
@youtube_links = 0
Wikialgo.where(:category => /graph/i).each do |w|
  w.pages.where(:link=>/stackoverflow.com/i).each do |pg|
    pg.prank = -1
    pg.save
    @youtube_links= @youtube_links +1
  end
end
puts @youtube_links
puts @pt.count
#w.pages.where(:link => /xlinux.nist.gov/i).each do |pg| 
#  pg.prank = 3
#  pg.save
#  puts pg.link
#  @youtube_links= @youtube_links +1
# end
# w.pages.where(:link => /en.wikipedia.+#{w.title.gsub(" ","_")}/i).each