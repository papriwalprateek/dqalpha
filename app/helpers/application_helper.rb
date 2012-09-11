module ApplicationHelper
    def title   
        base_title = "DaQuest" 
        if @title.nil?
            base_title
        else
            "#{base_title} | #{@title}" 
        end
    end
    def wiki_content( a )
    
    if a
    require 'rubygems'
    require 'wikicloth'
    require 'media_wiki'
    mw = MediaWiki::Gateway.new('http://en.wikipedia.org/w/api.php/')
    wiki =  mw.render(a) 
    @doc = Nokogiri::HTML(wiki)
    wiki = @doc.xpath('//p[1]')
    
    return @content if defined?(@content)
    @content = raw wiki
    
    end
  end
 
end
