file = open("lib/rdftags.json")
json = file.read
parsed = JSON.parse(json)
for i in parsed
	r = Rdf.new
	r.q_id = i["id"].to_i
	r.quest_id = 207
	r.tags = []
	k = i["tags"]
	for j in k
		r.tags << j["tag"]
	end
	r.save!
end