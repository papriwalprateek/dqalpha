@name = ["Dang_Christophe", "Carrico_Paul"]
@name.each do |name|
	namee = name.gsub(",","_")
	namee = name.gsub(" ","_")
	
	u = User.new(:name => name,:password =>name, :password_confirmation =>name,:email =>namee+"@daqwest.com" )
	u.save
	u.verify!
end