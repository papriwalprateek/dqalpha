module ApplicationHelper
    def title   
        base_title = "DaQuest" 
        if @title.nil?
            base_title
        else
            "#{base_title} | #{@title}" 
        end
    end
def wiki_content(a)
    

 if a
    require 'rubygems'
    require 'wikicloth'
    require 'media_wiki'
    mw = MediaWiki::Gateway.new('http://en.wikipedia.org/w/api.php/')
    wiki =  mw.render(a)
    @doc = Nokogiri::HTML(wiki)
    
    note = @doc.search("sup")
    note.remove
    note = @doc.search("a.external")
    note.remove
    note = @doc.search("span")
    note.remove

    introimage = @doc.css('table.infobox a.image')[0]['href']
    @introimage = introimage 
    
    note = @doc.css("table.infobox a.image")
    note.remove
    
    name = a
    
    note = @doc.at_css("table.infobox tr")
    note.remove
    
    image = @doc.css('table.infobox')[0]

#@infobox = Nokogiri::HTML(image)

#introimage = @doc.css('table.infobox a.image')
#a1 = @doc.css('table.infobox tr')[2]
#a2 = @doc.css('table.infobox tr')[3]
  
    if image == nil
      image = @doc.css('a.image')[0]  
    end

    info = @doc.xpath('//p')[0].text
  
    return @content if defined?(@content)
    @image = image
    @info = info
    @name = name
    if @introimage
    @stringurl = "http://en.wikipedia.org" + @introimage
    end 
    @doc1 = Nokogiri::HTML(open(@stringurl))
    introimage = @doc1.css('div.fullImageLink > a')[0]['href']
    @introimage = introimage
    
    if @introimage
    @introimage = "http:" + @introimage
    end 
#    @seealso = seealso
#    @content = "This is a dummy text about your query which is auto generated, it will be soon replaced by wikipedia text which will be fetched through mediawiki"
    end
  

  end
 
end
