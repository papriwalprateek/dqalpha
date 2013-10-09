@vm_list = ["scilab_help,""bugzilla_search","so_search"]
@vm_list.each do |name|
	
	u = Vm.new(:name => name )
	u.save
end