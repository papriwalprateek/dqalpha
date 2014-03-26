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

* Setting postgres (ubuntu)
	-  ``` sudo apt-get install postgres postres-contrib ```
	-  ``` sudo apt-get install libpq-dev ```
	-  Setting postgres database (set password as well)

* Creating and migrating the tables - 

	```ruby
	rake db:create 
	rake db:migrate
	```
* rake pg_search:multisearch:rebuild[Qmail]

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


## Handy Tools and Codes

* To reset search documents table execute this in rails console
  ActiveRecord::Base.connection.execute("DELETE from pg_search_documents")
  For viewing table information run heroku pg:psql and then following
    	
	```sql
	SELECT schemaname,relname,n_live_tup
	FROM pg_stat_user_tables
	ORDER BY n_live_tup DESC; 
	```

* JSON Builder
  - Execute the code shown below to develop a arraylist in the given format.
	
	```ruby
	@users = User.all
	@userlist = []
	@users.each do |user|
  		@userlist << {
    		:id => user.id,
	  	:fname => user.fname,
    		:lname => user.lname,
    		:photo => user.profile_pic.url(:small)
  		}
	end
	```
  
  - Save the above generated content in a file
  	
	```ruby
	File.open("yourfile.json","w"){|file| file.write(@userlist.to_json)}
	```
  
  - Then load the json file again and parse the file using JSON
  	
	```ruby
	file = open("yourfile.json")
	json = file.read
	parsed = JSON.parse(json)
	```
	
## Mongodb alongside Activerecord

 Mongoid by default overrides the default activerecord generators so need to
 use following commands to generate activerecord models or migrations.	
	```ruby
	rails g active_record:model Xyz
	```
	
## PgSearch issues
 
 Words too long to be indexed - this error is because of some of the qmails have content which have xml tags
 like "<w:", "gte 9" etc. removing these removes this error.
 
## Rails 2.3 style plugins deprecation warning

 installing rails_12 factor gem resolved the issue
