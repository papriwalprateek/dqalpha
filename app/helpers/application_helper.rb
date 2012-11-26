module ApplicationHelper
    def title   
        base_title = "DaQuest" 
        if @title.nil?
            base_title
        else
            "#{base_title} | #{@title}" 
        end
    end
    def markdown(text)
  options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
   markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new( :hard_wrap => true),
        :autolink => true, :fenced_code => true, :no_intraemphasis => true,:gh_blockcode=> true,:strikethrough=>true)
#  markdown.render(text).html_safe;
 raw syntax_highlighter(markdown.render(text))
end

def syntax_highlighter(html)
  doc = Nokogiri::HTML(html)
  doc.search("//pre[@lang]").each do |pre|
    pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
  end
  doc.to_s
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
#    note = @doc.search("a.external")
#   note.remove
#    note = @doc.search("span")
 #   note.remove
begin #handling no image exceptions 
    introimage = @doc.css('table.infobox a.image')[0]['href']
    @introimage = introimage 
rescue
  @introimage = "nothing_here"
end  
    note = @doc.css("table.infobox a.image")
    note.remove
    
    name = a
begin    #handling no table exceptions
    note = @doc.at_css("table.infobox tr")
    note.remove
rescue 
end   
    image = @doc.css('table.infobox')[0]

#@infobox = Nokogiri::HTML(image)

#introimage = @doc.css('table.infobox a.image')
#a1 = @doc.css('table.infobox tr')[2]
#a2 = @doc.css('table.infobox tr')[3]
  
    if image == nil
      image = @doc.css('a.image')[0]  
    end
begin
    info = @doc.xpath('//p')[0].text
rescue
info = "sorry no data found"
end
    return @content if defined?(@content)
    @image = image
    @info = info
    @name = name
    if @introimage !="nothing_here"
    @stringurl = "http://en.wikipedia.org" + @introimage
    else 
      @stringurl = "nothing_here"
    end 
    if @stringurl !="nothing_here"
    @doc1 = Nokogiri::HTML(open(@stringurl))
    introimage = @doc1.css('div.fullImageLink > a')[0]['href']
    @introimage = introimage
    end
    if @introimage !="nothing_here"
    @introimage = "http:" + @introimage
    end 
#    @seealso = seealso
#    @content = "This is a dummy text about your query which is auto generated, it will be soon replaced by wikipedia text which will be fetched through mediawiki"
    end
  

  end
 
end
