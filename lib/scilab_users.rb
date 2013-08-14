@name = ["Niels Peter Fenger", "Stanislav", "owsigplc", "arctica1963", "Debola Abduljeleel", "grivet", "Samuel GOUGEON", "Pascal Buehler", "Serge Steer", "barbaraflowers", "Rafael Guerra", "oscar.espejo", "Michael J. McCann", "Antoine Monmayrant", "Michael J. McCann-2", "matacosta", "Sylvestre Ledru-4", "shorne", "omorr", "ezequiel soule", "Mathieu Dubois", "Adrien Vogt-Schilb", "cactus_jack", "Denis", "Amsdenyt", "Marria", "lukeaarond", "pepe", "F. Vogel", "F. Vogel-2", "jhdtyp", "Eze-Okoli Ifeoma Sandra", "Dang, Christophe", "jasper van baten", "Nima Sahraneshin-Samani", "A Khorshidi", "Janusz Magrian", "rajesh kannan", "Stefan Du Rietz", "stef296", "papriwalprateek", "Jacqueline Howe", "jacquih", "Paul Carrico", "Carrico, Paul", "martin.highUp", "simi99", "oiwmw", "Chuox", "Larissa", "Mike Page", "windkraft", "babigeon"]
@name.each do |name|
	namee = name.gsub(",","_")
	namee = name.gsub(" ","_")
	
	u = User.new(:name => name,:password =>name, :password_confirmation =>name,:email =>namee+"@daqwest.com" )
	u.save
	u.verify!
end