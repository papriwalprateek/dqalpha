file = open("lib/algorithm.json")
json = file.read
parsed = JSON.parse(json)
for i in parsed
	r = Wikialgo.new
	r.link = i["link"]
	r.htag = i["name"]
	r.save!
end