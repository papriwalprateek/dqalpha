#open each page and then go to each given link 
#for each link search for the link in database if not found save it in array
#if found increment it's value by 1
#go to next page
 require 'rubygems'
  require 'wikicloth'
    require 'media_wiki'
    require 'nokogiri'
    require 'open-uri'
pages = Wikialgo.find_by("title" => /bubble/i).pages
old_links = []
pages.each do |page|
old_links << page.link
end

pages.each do |page|
	
	a = page.link
	
  	source = URI.encode(a)
  	@y =  DQReadability::Document.new(source,:tags=>%w[div pre p h1 h2 h3 h4 td table tr b a img br li ul ol center br hr blockquote em strong],:attributes=>%w[href src align width  color]).html
  	
	links = @y.css('a')
	puts links.count
	links.each do |lin|
		link = lin['href']
		begin 
		p = Wikialgo.find_by("pages.link" =>link)
		if (old_links.include?(link) && link!=page.link && p)
			puts "found link"
			puts link
			q = p.pages.find_by("link" =>link)
			q.prank = q.prank+1
			puts q.prank
			q.save
		end
		rescue Exception => e
			puts e
		end
	end

end


