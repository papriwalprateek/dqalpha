require "nokogiri"
@already_visited = {}

def crawl_domain(url,param1)
#	return if @already_visited.size == 10
	noko_object = Nokogiri::HTML(open(url))
	return if noko_object == nil
	
	@already_visited[url] = true if @already_visited[url] == nil
	
	page_urls = find_urls_on_page(noko_object)
	puts url
	page_urls.each do |page|
		if url != page and @already_visited[page] == nil and page.include? (param1) and !(page.include? "archives") and !(page.include? "#") and !(page.include? "forum") and !(page.include? "comment") 
			begin
			crawl_domain(page)
			rescue
			end
		end
	end
	
	File.open("~/mylinks1.rb", 'w') { |file| file.write(@already_visited) }
end	

def find_urls_on_page(noko)
	urls_list = []
	templist = noko.css('a[@href]')
	templist.each do |tmp|
		urls_list.push(tmp.attributes["href"].value)
	end
	return urls_list
end

