#!/usr/local/bin/ruby
# coding: utf-8

@corpus = {"Sequence sorting"=>{"Bubble sort"=>[["Bubble sort - Wikipedia, the free encyclopedia", "http://en.wikipedia.org/wiki/Bubble_sort"]]}}

c = @corpus["Graph algorithms"]

c.each do |d|
	w = Wikialgo.new
	w.title = d[0]
	w.category = "Graph algorithms"
	w.save
	kt = d[1]
	kt.each do |kk|
		p = Page.new
		p.title = kk[0]
		p.link = kk[1]
		p.wikialgo = w
		p.save
	end
	puts w.title
	puts w.pages.count
end