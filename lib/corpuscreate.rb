#whole of this code will be run in loop for all algorihms of Wikialgo corpus
algos = ["kruskal", "prim's",  "selection sort", "bubble sort", "merge sort", "heapsort", "dijkstra's"]
#algos.each do |al|
#Wikialgo.find_by(:htag => al)
@doc = Nokogiri::HTML(open("https://www.google.co.in/search?q=bubble+sort"))
# in this bubble sort will be replaced by htag from wikialgo corpus

gtags = @doc.css("h3.r")
glinks = @doc.css("h3.r>a")

@tags = []
@links = []

gtags.each do |t|
	@tags << t.text
end

glinks.each do |l|
	temp = l.attributes["href"].value	
	@links << temp.gsub("/url?q=","").split("&")[0]
end

@corpus = {}
j = 0
resources = []

blacklist = ["wikipedia","youtube","rosetta","geeksforgeeks"]

while j < @tags.length
	flag = 1
	blacklist.each do |b|
		if @links[j].include?(b)
			flag = 0
		end
	end
	if flag == 1
		dup = [@tags[j],@links[j]]
		resources << dup
	end
	j = j + 1
end

@corpus["Bubble sort"] = resources
w = Wikialgo.find_by(:htag => /bubble/i)
resources.each do |r|
	p = Page.new
	p.link = r[1]
	p.title = r[0]
	p.wikialgo = w
	p.save
# in this bubble sort will be replace by htag of wikialgo corpus
end