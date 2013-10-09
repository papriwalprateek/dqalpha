@vm_list = ["scilab_help","so_search","bugzilla_search"]
@vm_list.each do |name|
	
	u = Vm.new(:name => name )
	u.save
end