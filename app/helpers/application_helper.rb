module ApplicationHelper
    def title   
        base_title = "DaQuest" 
        if @title.nil?
            base_title
        else
            "#{base_title} | #{@title}" 
        end
    end
    def wiki_content
    
    if params[:q] 
    require 'rubygems'
    require 'wikicloth'
    require 'media_wiki'
    mw = MediaWiki::Gateway.new('http://en.wiktionary.org/w/api.php/')
    wiki =  mw.render(params[:q]) 
    @doc = Nokogiri::HTML(wiki)
    wiki = @doc.xpath('//ol')
    return @content if defined?(@content)
    @content = wiki
    end
  end
 
end
