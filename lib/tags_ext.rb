# tags extractor

load "methods.rb"

@q = Q.where(:quest_id=>207)
 
@tags_extract = {}

@q.each do |qs|
	@tags_extract[qs.id] = []
	qs.qmails.each do |qmail|
		j = 0
		a = qmail.content
		len = a.gsub(/[,.()!]/," ").split(" ").length

		tokens = a.gsub(/[,.()!]/," ").split(" ")

		while j < len
		if @methods.include?(tmp=tokens[j])
			if !(@tags_extract[qs.id].include?(tmp))
				if tmp.length > 3
				@tags_extract[qs.id] << tmp
				end
			end
		end
		j = j + 1
		end
	end
end
	


# JSON builder

j = 0
@mashupRDF = []

while j < @tags_extract.length
	temp =[]
	@tags_extract.values[j].each do |x|
		temp << {:tag => x}
	end

	@mashupRDF << {
		:id => @tags_extract.keys[j].to_s,
		:tags => temp,
		:so => [],
		:bugs => []
		}

	j = j + 1
end


File.open("lib/rdftags.json","w"){|file| file.write(@mashupRDF.to_json)}
