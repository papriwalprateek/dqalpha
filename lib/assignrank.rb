@pt =[]
@youtube_links = 0
Wikialgo.where(:category => /combinato/i).each do |w|
w.pages.where(:link=>/rosetta/i).each do |pg|
    pg.prank = 2
    pg.save
   # puts w.title
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
#pg.link = pg.link.gsub("watch?v=","embed/")
    