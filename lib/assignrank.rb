@p =[]
@youtube_links = 0
Wikialgo.each do |w|
 w.pages.each do |pg| 
 if (pg.prank == 3)
 @p << pg
 end
 end
end
puts @p.count