## Virtual Member(VM)

It is a resource of knowledge that could be used to enrich a quest with information about various things,
it could be a dataset like mailing lists or an api like mediawiki fetching information from wikipedia or some static websites or 
documentations, all wrapped around in a standard manner i.e. our VM API, to provide information.

## VM API

*  Making a new vm
	```
	u = Vm.new(:name => vm_name )
	u.save
	```
* Add a method for this vm in application_helper such that

	-  It's name is vm_name

	-  it inserts the titles of it's results in @arr for example if a vm is giving two results "description" and "example" about the query then it 	should do ...   @arr << "description" and @arr << "example" that will help the platform to list it's results into respective places. 

*  Adding a custom vm to a quest

	-  ``` Quest.find(quest_id) << Vm.find(vm_id) ```

## Setting up environment

* Creating and migrating the tables - 

	```
	rake db:create 
	rake db:migrate
	```
* rake pg_search:multisearch:rebuild[Qmail]

* To reset search documents table execute this in rails console
  ActiveRecord::Base.connection.execute("DELETE from pg_search_documents")
  For viewing table information run heroku pg:psql and then following
    	```
	SELECT schemaname,relname,n_live_tup
	FROM pg_stat_user_tables
	ORDER BY n_live_tup DESC;
	```
* For local windows machine proxy settings using the manual way given at https://gist.github.com/fnichol/867550 
  and set https_proxy=proxy:port


## Core Technology at the root - Linked Data

> Linked Data describes a method of publishing structured data so that it can be interlinked and become more useful. 
> It builds upon standard Web technologies such as HTTP, RDF and URIs, but rather than using them to serve web pages for human readers, it extends them to share information in a way that can be read automatically by computers. 
> This enables data from different sources to be connected and queried.

## Proxy issues
On windows SET HTTPS_PROXY=http://server-ip:port/ to use heroku commands from CLI
also if heroku run rake db:migrate does not work following might be useful
heroku run:detached rake db:migrate
