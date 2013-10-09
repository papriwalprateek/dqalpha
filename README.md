rake db:migrate

rake pg_search:multisearch:rebuild[Qmail]

#Virtual Member(VM)
It is a resource of knowledge that could be used to enrich a quest with information about various things,
it could be a dataset like mailing lists or an api like mediawiki fetching information from wikipedia or some static websites or 
documentations, all wrapped around in a standard manner i.e. our Vm API, to provide information.

#VM API

+  Making a new vm

	u = Vm.new(:name => vm_name )
	u.save
	Add a method for this vm in application_helper such that

	-  It's name is vm_name

	-  it inserts the titles of it's results in @arr for example if a vm is 	giving two results "description" and "example" about the query then it 		should do ...   @arr << "description" and @arr << "example" that will help 	   the platform to list it's results into respective places. 

+  Adding a custom vm to a quest

	Quest.find(quest_id) << Vm.find(vm_id)
