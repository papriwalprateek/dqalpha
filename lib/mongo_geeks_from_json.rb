file = open("lib/geeksjson.json")
json = file.read
parsed = JSON.parse(json)
for i in parsed
	r = Geekslink.new
	r.link = i["link"]
	r.htag = i["htag"]
	r.save!
end