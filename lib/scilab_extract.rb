@name = ["Niels Peter Fenger", "Stanislav", "owsigplc", "arctica1963", "Debola Abduljeleel", "grivet", "Samuel GOUGEON", "Pascal Buehler", "Serge Steer", "barbaraflowers", "Rafael Guerra", "oscar.espejo", "Michael J. McCann", "Antoine Monmayrant", "Michael J. McCann-2", "matacosta", "Sylvestre Ledru-4", "shorne", "omorr", "ezequiel soule", "Mathieu Dubois", "Adrien Vogt-Schilb", "cactus_jack", "Denis", "Amsdenyt", "Marria", "lukeaarond", "pepe", "F. Vogel", "F. Vogel-2", "jhdtyp", "Eze-Okoli Ifeoma Sandra", "jasper van baten", "Nima Sahraneshin-Samani", "A Khorshidi", "Janusz Magrian", "rajesh kannan", "Stefan Du Rietz", "stef296", "papriwalprateek", "Jacqueline Howe", "jacquih", "Paul Carrico", "martin.highUp", "simi99", "oiwmw", "Chuox", "Larissa", "Mike Page", "windkraft", "babigeon","Dang_Christophe", "Carrico_Paul"]

j = 0
user_id_offset = 648
urls_list = ["http://mailinglists.scilab.org/Scilab-users-Plot-function-in-scilab-tp4027208.html", "http://mailinglists.scilab.org/Scilab-users-discrete-cosine-transform-tp4027189.html", "http://mailinglists.scilab.org/Scilab-users-STEP-Datei-tp4027130.html", "http://mailinglists.scilab.org/Personal-training-Technologies-This-Power-Adidas-Operating-Shoes-tp4027200.html", "http://mailinglists.scilab.org/Standalone-viewing-of-Scilab-scg-graphic-files-tp4027198.html", "http://mailinglists.scilab.org/problem-with-uicontrol-table-tp4027196.html", "http://mailinglists.scilab.org/Scilab-users-5-4-1-Cannot-create-Java-Main-Class-tp4027176.html", "http://mailinglists.scilab.org/Scilab-users-ODE-Simulation-Problem-Initially-solved-with-FORTRAN-to-be-numrically-solved-using-Scilb-tp4027186.html", "http://mailinglists.scilab.org/Scilab-users-problem-loading-environments-tp4027131.html", "http://mailinglists.scilab.org/Scilab-users-Scilab-console-xwindows-plotting-kills-console-keyboard-tp4027174.html", "http://mailinglists.scilab.org/Copying-an-array-tp4027149.html", "http://mailinglists.scilab.org/Your-shoes-for-that-activities-man-resembles-the-particular-edge-for-your-gamers-tp4027170.html", "http://mailinglists.scilab.org/Soccer-Uniforms-tp4027166.html", "http://mailinglists.scilab.org/Scilab-users-Adding-Scroll-Bar-to-uicontrol-GUI-tp4027163.html", "http://mailinglists.scilab.org/scipad-8-71-install-tp4027153.html", "http://mailinglists.scilab.org/Adding-Scroll-Bar-to-uicontrol-GUI-tp4027159.html", "http://mailinglists.scilab.org/puma-schuhe-motorsport-tp4027147.html", "http://mailinglists.scilab.org/Scilab-users-no-subject-tp4027129.html", "http://mailinglists.scilab.org/Scilab-users-link-Wrong-value-for-input-argument-tp4027116.html", "http://mailinglists.scilab.org/Scilab-users-C-Block-code-editor-tp4027125.html", "http://mailinglists.scilab.org/Scilab-users-scilab-figure-window-toolbar-icon-remove-tp4027109.html", "http://mailinglists.scilab.org/Loading-data-from-URL-tp4027104.html", "http://mailinglists.scilab.org/Scilab-users-gcf-tp4027097.html", "http://mailinglists.scilab.org/Scilab-users-Problems-installing-Scilab-XLL-in-Excel-2007-tp4027111.html", "http://mailinglists.scilab.org/Scilab-users-Problems-installing-Scilab-XLL-in-Excel-2007-tp4027106.html", "http://mailinglists.scilab.org/Re-Scilab-compiling-tp4027102.html", "http://mailinglists.scilab.org/Scilab-users-Scilab-compiling-tp4027101.html", "http://mailinglists.scilab.org/Scilab-users-eomday-tp4027096.html", "http://mailinglists.scilab.org/Scilab-users-scilab-and-Centos-tp4027093.html", "http://mailinglists.scilab.org/Scilab-users-evaluation-of-a-Scilab-expression-from-Java-in-the-current-Scilab-environment-tp4027087.html", "http://mailinglists.scilab.org/Duration-time-of-Xcos-simulation-tp4027041.html", "http://mailinglists.scilab.org/Scilab-users-Undefined-variable-MSDOS-tp4027080.html", "http://mailinglists.scilab.org/Thomas-Sabo-Charms-2013-tp4027083.html", "http://mailinglists.scilab.org/Integrating-SciLab-and-EPANET-dll-written-in-C-C-tp4026977.html", "http://mailinglists.scilab.org/Scilab-users-using-wavelet-toolbox-under-scilab-tp4027061.html"]

while j < urls_list.length
	@doc = Nokogiri::HTML(open(urls_list[j]))
    @qtitle = @doc.css('h1#post-title').text
    
    # feed qtitle in the database here
    qu = Quest.find(207)
	q = qu.qs.create(:title =>@qtitle)
    @qcontent = @doc.css('div.message-text')
    i = 0
    while i < @qcontent.length
		x = @doc.css('table.classic-author-name')[i].text
		x = x.gsub("\t","")
		x = x.gsub("\n","")
		
		if x.include?("Denis")
			x = "Denis"
		end
		if x.include?("Dang,")
			x = "Dang_Christophe"
		end
		if x.include?("Carrico,")
			x =  "Carrico_Paul"
		end
		if x.include?("Vogel-2")
			x = "F. Vogel-2"
		elsif x.include?("Vogel")
			x = "F. Vogel"
		end
		
		u_id = user_id_offset+@name.index(x)
		qmail = q.qmails.create(:content=>@qcontent[i].inner_html, :user_id =>u_id )
		# feed the above u_id as userid ... u need to manipulate accordingly
		# feed @qcontent[i].inner_html as qmail content
		
		i = i + 1
	end  
	
	
	j = j + 1
end