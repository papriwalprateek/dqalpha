#!/usr/local/bin/ruby
# encoding: UTF-8

c = @corpus["Dynamic Programming"]

c.each do |d|
	w = Wikialgo.new
	w.title = d[0]
	w.category = "Dynamic Programming"
	w.save
	kt = d[1]
	kt.each do |kk|
		p = Page.new
		p.title = kk[0]
		p.link = kk[1]
		if kk[2]
		p.img_url = kk[2]
		puts "img "
		end
		p.wikialgo = w
		p.save
	end
	puts w.title
	puts w.pages.count
end