@q_arr = []
Qmail.all.each do |q|
	x = q.content.split(" ")
	x.each do |k|
		 if k.split(//).length > 500
  			@q_arr<<q.id
		end
	end
end