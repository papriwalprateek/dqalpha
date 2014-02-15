module ApplicationHelper 
    def title   
        base_title = "DaQwest" 
        if @title.nil?
            base_title
        else
            "#{base_title} | #{@title}" 
        end
    end
    
    def invite(user_name,user_id,quest_id,quest_title,invited_user_email)
      user = User.where("email=?",invited_user_email)[0]
      if user
       user.notifications.create(:content => (user_name+" invited you to join "+quest_title),:sender_id => user_id, :has_read=>false, :url=>"/quests/"+quest_id.to_s())
      else
      end
       UserMailer.invite_mail(quest_id,user_name,invited_user_email).deliver   
    end
    
    def is_member_of(user_id,quest_id)
      i = Involvement.where("user_id =? AND quest_id =?",user_id,quest_id)
      if i[0].nil?
        return false
      else
       return i[0].id
      end
    end
    
    def recommended_quests(user_id)
      all_q = [26,207]
      q = []       
      all_q.each do |quest_id|
        if Quest.where("id = ?",quest_id)[0]
          i = Involvement.where("user_id =? AND quest_id =?",user_id,quest_id)
          if i[0].nil? 
            q<<quest_id
          end      
        end            
      end
    return q
    end

# def markdown(text)
#  options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
#   markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new( :hard_wrap => true),
#        :autolink => true, :fenced_code => true, :no_intraemphasis => true,:gh_blockcode=> true,:strikethrough=>true)
#  markdown.render(text).html_safe;
# raw syntax_highlighter(markdown.render(text))
#end

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
    require 'nokogiri'
    require 'open-uri'
    
    mw = MediaWiki::Gateway.new('http://en.wikipedia.org/w/api.php/')
    @catch = false
    begin
    wiki = mw.render(a.to_s.titleize)
  
    rescue MediaWiki::APIError => e
    begin
  wiki =  mw.render(a)
    rescue MediaWiki::APIError => e
    @catch = true
    end
    end
    
    @doc = Nokogiri::HTML(wiki)

    disam = @doc.css('p').text.split(' ').include? 'refer'
# testing if there is a case of REDIRECT    
#    redirect = @doc.css('li').children.text.split(' ')
#    redirect = redirect[0]
#    if redirect == 'REDIRECT'
# print "This is redirect case"
#    @name = a
#    a = a.to_s.gsub ' ', '_'
#    @docR = Nokogiri::HTML(open("http://en.wikipedia.org/wiki/"+a))
#    x = @docR.css("table.metadata.mbox-small.plainlinks")
#    x.remove
#    y = @docR.css("table#disambigbox")
#    y.remove
#    @content = @docR.css('div.mw-content-ltr')

# testing if there is a case of REDIRECT   
    
    if disam
  print "This is disambiguation case"
    @name = a
    a = a.to_s.gsub ' ', '_'
    @docdis = open_html("http://en.wikipedia.org/wiki/"+a)
    y = @docdis.css("table#disambigbox")
    y.remove
    @content = @docdis.css('div.mw-content-ltr')

    else
    
    redirect = @doc.css('li').children.text.split(' ')
    redirect = redirect[0]
    if redirect == 'REDIRECT'
  print "This is redirect case"
    a = a.to_s.gsub ' ', '_'
    @doc = open_html("http://en.wikipedia.org/wiki/"+a)
  end
  
    x = @doc.css("span.editsection")
    x.remove
    x = @doc.css("span.mw-editsection")
  x.remove
    @txtful = [] 
    j = 0
   
    while @doc.xpath("//h2/span")[j+1]!=nil
    @txt = [] 
    @node = @doc.xpath("//h2/span")[j].parent
    @stop = @doc.xpath("//h2/span")[j+1].parent
    while @node!=@stop
      @txt << @node
      @node = @node.next 
    end
    @txtful << @txt
    j = j + 1
    end
    print @txtful.length
    
    note = @doc.search("sup")
    note.remove

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

    if image == nil
      image = @doc.css('a.image')[0]  
    end
begin
    info = @doc.xpath('//p')[0]
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
    @doc1 = open_html(@stringurl)
    introimage = @doc1.css('div.fullImageLink > a')[0]['href']
    @introimage = introimage
    end
    if @introimage !="nothing_here"
    @introimage = "http:" + @introimage
    end 
end
    end
  end
def so_content(a)
   
   require 'pilha'
   StackExchange::StackOverflow::Client.config do |options|
      options.api_key = 'Sd9owvzqRd)VnsNfrCAJwA(('
   end   
   #since our so_content method can be passed both question id or link
    a = a.to_s
    a = a.split("stackoverflow.com/questions/")
    a = a[1].to_i
 
   @doc = StackExchange::StackOverflow::Question.find a, :query => {:body => true , :answers => true} 
# something like below can be done if we can get a nokogiri instance of this @doc
#    @doc.xpath('//a[@href]').each do |l|
#  l.attributes["target"].value = "_blank"
#  end
   @ques = @doc.title
   @desc = @doc.body 
   j=0
   @answers = []
   if @doc.answers
   while j < @doc.answers.length
      @ans = @doc.answers[j]["body"]
      @answers << @ans
      j = j + 1   
   end
  end
end
def so_search(a)   
    a = a.gsub(" ","+")
    @doc = open_html("http://www.stackoverflow.com/search?q=[scilab]+"+a)
    if @doc then
     @reco = @doc.css("div.result-link")
     if @reco[0]
       @arr<<"qna"
     end
     @reco_desc = @doc.css("div.excerpt")
     @links = @reco.css('a').map {|link| link["href"]}
     
    end 
    
end
def scilab_help(a)
   
   @doc = open_html("http://help.scilab.org/docs/current/en_US/"+ a + ".html")
   x = @doc.css("img")
   x.remove
   
   @description = []
   @example = [] 
   @relatedfunc = []
   
   @scilab_title = @doc.css("div.refnamediv")
   @callseq = @doc.css("div.refsynopsisdiv")
    
   @refsec = @doc.css("div.refsection")
   @refsec.each do |t|
        if t.css("h3").text == "Description"
      t.css("h3").remove
            @description << t
        end
   end
   @description << @callseq
   @refsec.each do |t|
        if t.css("h3").text == "Arguments"
            @description << t
        end
   end

   @refsec.each do |t|
        if t.css("h3").text == "Examples"
      t.css("h3").remove
            @example << t
        end
   end

   @refsec.each do |t|
        if t.css("h3").text == "See Also"
      t.css("h3").remove
      t.css("li").each do |l|
      l.xpath("a")[0].attributes["href"].value = "search?search=" + l.xpath("a")[0].attributes["href"].value.split(".")[0]
      @relatedfunc << l
      end
        end
   end
       @arr<<"description"
        if @example[0] then
          @arr<<"examples"
        end
        @arr<<"related"
 end
 def bugzilla_help(a)

   
   @doc = open_html(a)
   
   @ques = @doc.css("td.field_label")[1].parent.child.next.next.text
   @desc = @doc.css("pre")[0]
   j = 0
   @answers = @doc.css("pre.bz_comment_text")
   
end
def bugzilla_search(a)
  
   a = a.gsub(" ","+")
  
   @doc = open_html("http://bugzilla.scilab.org/buglist.cgi?quicksearch="+a+"&order=resolution")
   if @doc then
    @shortdesc = @doc.css("td.bz_short_desc_column")
    if @shortdesc[0] then
      @arr<<"bugs"
    end
    @component = @doc.css("td.bz_component_column")
    @datemodified = @doc.css("td.bz_changeddate_column")
    @bz_links = @shortdesc.css('a').map {|link| link["href"]}
    
   end  
end
def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end 

def scilab_extract_it(url)
@name = ["Niels Peter Fenger", "Stanislav", "owsigplc", "arctica1963", "Debola Abduljeleel", "grivet", "Samuel GOUGEON", "Pascal Buehler", "Serge Steer", "barbaraflowers", "Rafael Guerra", "oscar.espejo", "Michael J. McCann", "Antoine Monmayrant", "Michael J. McCann-2", "matacosta", "Sylvestre Ledru-4", "shorne", "omorr", "ezequiel soule", "Mathieu Dubois", "Adrien Vogt-Schilb", "cactus_jack", "Denis", "Amsdenyt", "Marria", "lukeaarond", "pepe", "F. Vogel", "F. Vogel-2", "jhdtyp", "Eze-Okoli Ifeoma Sandra", "jasper van baten", "Nima Sahraneshin-Samani", "A Khorshidi", "Janusz Magrian", "rajesh kannan", "Stefan Du Rietz", "stef296", "papriwalprateek", "Jacqueline Howe", "jacquih", "Paul Carrico", "martin.highUp", "simi99", "oiwmw", "Chuox", "Larissa", "Mike Page", "windkraft", "babigeon","Dang_Christophe", "Carrico_Paul"]

  user_id_offset = 648
    @doc = open_html(url)
    @qtitle = @doc.css('h1#post-title').text
    
    # feed qtitle in the database here
    qu = Quest.find(207)
  q = qu.qs.create(:title =>@qtitle)
    q.add_questid(207)#tells pg_search about quest id these two lines are must after each q or qmail create  
 
    @qcontent = @doc.css('div.message-text')
    i = 0
    while i < @qcontent.length
    x = @doc.css('table.classic-author-name')[i].text
    x = x.gsub("\t","")
    x = x.gsub("\n","")
    
    if x.include?("Denis")
      x = "Denis"
    end
    if x.include?("Dang,")
      x = "Dang_Christophe"
    end
    if x.include?("Carrico,")
      x =  "Carrico_Paul"
    end
    if x.include?("Vogel-2")
      x = "F. Vogel-2"
    elsif x.include?("Vogel")
      x = "F. Vogel"
    end
    if @name.index(x)      
     u_id = user_id_offset+@name.index(x)
    else
      u_id = 703
    end
    qmail = q.qmails.create(:content=>@qcontent[i].inner_html, :user_id =>u_id )
    qmail.add_questid(207)

    # feed the above u_id as userid ... u need to manipulate accordingly
    # feed @qcontent[i].inner_html as qmail content
    
    i = i + 1
  end  
  
end

def algorithm_wiki(a)
  if a
    puts "inside algorithm vm"
    require 'media_wiki'
    require 'nokogiri'
    require 'open-uri'
    require 'wikicloth'
   puts a
    @catch = false
    begin
  b = URI.encode(a)
   @doc = Nokogiri::HTML(open(a))
    rescue 
    begin
   
   @doc = Nokogiri::HTML(open(b))
   puts b
     puts "rescue mein"
    rescue 
     puts "second rescue mein"
    @catch = true
    end
    end

    @wiki_definition = []

    redirect = @doc.css('li').children.text.split(' ')
    redirect = redirect[0]
    if redirect.include?'REDIRECT'
    print "This is redirect case"
    a = a.to_s.gsub ' ', '_'
    @doc = Nokogiri::HTML(open("http://en.wikipedia.org/wiki/"+a))
    end
    
    x = @doc.css("table.ambox")
    x.remove
      x = @doc.css(".portal")
    x.remove
     infobox = @doc.css("table.infobox")
    infobox.remove
    x = @doc.css('table.vertical-navbox')
  x.remove
# @wiki_definition << @doc.css("p")[0]
  @node = @doc.css("p")[0]
  @stop = @doc.css("div#toc")[0]
  @stop1 = @doc.css("h2 > span")[0].parent
  
  while @node!=@stop and @node!=@stop1
      @wiki_definition << @node
      @node = @node.next 
    end 
     if infobox
    @wiki_definition << @doc.css("table.infobox")
  end

  if @doc.css("table.infobox")
  @wiki_definition << @doc.css("table.infobox")
  end

  if @wiki_definition != []
       @arr<<"algo_description"
  end

# Mathematical Insights

  j = 0
  htag = -1
  
  @math_tags = ["solving","combinatorics","math","proof","relation","formulas","correctness"]  # This is tag array which empowers the math method
  
  while j < @doc.css("h2 > span").length
      @math_tags.each do |x|
      if @doc.css("h2 > span")[j].text.downcase.include?(x) 
        htag = j
      end
      end
      if htag >= 0
        j = @doc.css("h2 > span").length
      end
      j = j + 1
  end
  
  if htag >= 0
    @math = []
    @node = @doc.css("h2 > span")[htag].parent
    @stop = @doc.css("h2 > span")[htag+2].parent
    
    editsec = @doc.css("span.mw-editsection")
    editsec.remove
    
    @node = @node.next
    while @node!=@stop
      @math << @node
      @node = @node.next 
    end
    if @math != []
       @arr<<"math_analysis"
    end

  end

# Algo Complexity 
    
  j = 0
  htag = -1
  @cmplx_tags = ["efficiency","complexity","time","analysis","best","worst","average"]  # This is array of semantic tags which tags content related to algorithm complexity 
  
  while j < @doc.css("h2 > span").length
      @cmplx_tags.each do |x|
      if @doc.css("h2 > span")[j].text.downcase.include?(x)
        htag = j
      end
      end
      if htag >= 0
        j = @doc.css("h2 > span").length
      end
      j = j + 1
  end
  @cmplx = []
  if htag >= 0
    @node = @doc.css("h2 > span")[htag].parent
    @stop1 = @doc.css("h2 > span")[htag+1].parent
    @stop = @doc.css("h2 > span")[htag+2].parent
    
    editsec = @doc.css("span.mw-editsection")
    editsec.remove
    
    @node = @node.next
    while @node!=@stop and @node!=@stop1
      @cmplx << @node
      @node = @node.next 
    end
  end



# Algorithm

  j = 0
  htag = -1
  
  @algo_tags = ["algorithm","definition","description","encoding","overview","operation"]
  
  while j < @doc.css("h2 > span").length
      @algo_tags.each do |x|
      if @doc.css("h2 > span")[j].text.downcase.include?(x) 
        htag = j
      end
      end
      
      if htag >= 0
        j = @doc.css("h2 > span").length
      end
      j = j + 1
  end
  @algorithm = []
  if htag >= 0

    @node = @doc.css("h2 > span")[htag].parent
    @stop1 = @doc.css("h2 > span")[htag+1].parent
    @stop = @doc.css("h2 > span")[htag+2].parent
    
    editsec = @doc.css("span.mw-editsection")
    editsec.remove
    
    @node = @node.next
    while @node!=@stop and @node!=@stop1
      @algorithm << @node
      @node = @node.next 
    end
  end
  
  if @algorithm != [] or @cmplx != []
      @arr<<"algo_examples" 
  end


# Pseudocode

  j = 0
  htag = -1
  
  @pseudocode_tags = ["pseudocode","implementation"]
  
  while j < @doc.css("h2 > span").length
      @pseudocode_tags.each do |x|
      if @doc.css("h2 > span")[j].text.downcase.include?(x) 
        htag = j
      end
      end
      
      if htag >= 0
        j = @doc.css("h2 > span").length
      end
      j = j + 1
  end
  if htag >= 0
    @pseudocode = []
    @node = @doc.css("h2 > span")[htag].parent
    @stop1 = @doc.css("h2 > span")[htag+1].parent
    @stop = @doc.css("h2 > span")[htag+2].parent
    
    editsec = @doc.css("span.mw-editsection")
    editsec.remove
    
    @node = @node.next
    while @node!=@stop and @node!=@stop1
      @pseudocode << @node
      @node = @node.next 
    end
  end
  
  if @psuedocode != [] && @pseudocode!=nil
    
       @arr<<"code"
  end


# Related algorithms

  j = 0
  htag = -1
  
  @related_algo_tags = ["see also"]  # This is tag array which empowers the related algorithms method
  
  while j < @doc.css("h2 > span").length
      @related_algo_tags.each do |x|
      if @doc.css("h2 > span")[j].text.downcase.include?(x) 
        htag = j
      end
      end
      if htag >= 0
        j = @doc.css("h2 > span").length
      end
      j = j + 1
  end
  
  @related_algorithm = []
  if htag >= 0

    @node = @doc.css("h2 > span")[htag].parent
    @stop = @doc.css("h2 > span")[htag+2].parent
    @stop1= @doc.css("h2 > span")[htag+1].parent
    
    editsec = @doc.css("span.mw-editsection")
    editsec.remove
    
    @node = @node.next
    while @node!=@stop and @node!=@stop1
      begin 
      @node.css('a').each do |c|
      c.attributes["href"].value = "/search?search=" + c.attributes["title"].value
      end
      rescue
      end
      @related_algorithm << @node
      @node = @node.next 
    end
  end
  
  if @related_algorithm != []
      @arr<<"algo_related"
  end
  
  end
  end
  
  def algorithm_geeks(a)
    
  parsed  = Geekslink.where(:htag =>/#{a}/i).to_a()
  if @articles
  else
    @articles =[]
  end
  if parsed != []
    parsed.each do |c|
      c.link = "/geeks-link?ad=geeksforgeeks.org/"+c.link.split("forgeeks.org/")[1]
      @articles << {"link" => c.link,"title" => c.htag, "source" => "geeksforgeeks.org"}
    end
  end
  
  if @articles[0] != nil
    @arr<<"algo_article"
  end
 
end
def algorithm_webpages(a)
  par  = Wikialgo.find_by(:title => a)  
  parsed = par.pages.where(:prank.gt=>3).desc(:prank)
  @defs = par.descriptions
  #initialize output variables
  @articles =[]
  @embed_vid = []
  #send each link to it's respective module via classifier
  if parsed
   parsed.each do |p|
    begin  
      article_classify(p)
    rescue
    end
    end
  end  
  #setting result variable flags for front end ui tabs etc
  if @articles[0] != nil
    @arr<<"algo_article"
  end
  if @embed_vid[0] != nil
    @arr<<"videos"
  end
  
end

def article_classify(d)
   if d.link.include?("en.wikipedia")
     algorithm_wiki(d.link)
   #elsif(d.link.include?("geeksforgeeks.org"))
   #   @article << {"link" => "/geeks-link?ad="+d.link,"title" => d.title, "source" => "geeksforgeeks.org"} 
   elsif(d.link.include?("stackoverflow"))
   elsif(d.link.include?("rosettacode"))
     algorithm_rosetta(d.link)
   elsif(d.link.include?("www.youtube.com"))
     @embed_vid<<[d.title,d.link]
   elsif(d.link.include?("github"))
   elsif(d.link.include?(".pdf"))
   else
     source = ""
      if d.link.include?("http")
        source = d.link.split("/")[2]
      else
        source = d.link.split("/")[1]
      end
           @articles << {"link" => "/read?ad="+d.link,"title" => d.title, "source" => source}       
   end
     
end

def algorithm_geeks_extract(link)
  require "nokogiri"
   require "open-uri"
 puts link
  algogeekdoc = Nokogiri::HTML(open("http://www."+link))
  
  content = algogeekdoc.css("div#post-content")
  node = content.css("p")[0]
 
  @geekarticle = []
  @geekarticletitle = algogeekdoc.css("h2.post-title").text 
  while true
    @geekarticle << node
    node = node.next
    if node.text.include?("References:") or node.text.include?("Sources:") or node.text.include?("write comments") or node.text.include?("Please see")
        break
    end
  end
  
  puts Time.now().to_s()+"end"
  

end
def algorithm_rosetta(ad)
  par  = Wikialgo.find_by(:title => ad)  
  begin
  a = par.pages.find_by(:link=>/rosettacode.org/i).link
  rescue
  a = nil
  end
  begin
  rosdoc = Nokogiri::HTML(open(a))
  rescue
  end
  if rosdoc
  lang = [' C',' C++',' Java',' Javascript',' Matlab',' Python',' Ruby']

  x = rosdoc.css('span.editsection')
  x.remove

  @l = rosdoc.css('h2')


  @langcodes = []
  k = 0

while k < lang.length
    j = 0
    htag = -1
    while j < @l.length
        if lang[k] == @l[j].text
            htag = j
        end
        j = j + 1
    end
    
    if htag >= 0
        node = @l[htag]
        stop = @l[htag+1]
        
        temp = []
        while true
            if node == stop
                break
            end
            temp << node
            node = node.next
        end
        @langcodes << temp
    end
    k = k + 1
    if @langcodes!=[] && @langcodes!=nil
      @arr << "code"
    end
end
end    
end
def algorithm_git(a)
  @gitdoc = Nokogiri::HTML(open("https://github.com/search?q="+a.gsub(' ','+')+"&type=Repositories"))
    @git_repo = []
    x=@gitdoc.css('span.repolist-icon')
    x.remove
    x=@gitdoc.css('li.stargazers')
    x.remove
    x=@gitdoc.css('li.forks')
    x.remove
    
    j = 0
    while j < @gitdoc.css('li.source').length
      @git_repo << @gitdoc.css('li.source')[j]
      j = j + 1
    end
    if @git_repo!=[] && @git_repo!=nil
      @arr << "code"
    end
end
def corpus_extract(q)
  w = Wikialgo.find_by(title: q)
      if w
        e = w.elements
        if e
          @e_desc = e.where(type: "description").to_a
          @e_ex = e.where(type: "example").to_a
          @e_code = e.where(type: "code").to_a
        end
      end
      
  if @e_desc!=[]
    @arr << "algo_description"
  end
  if @e_ex!=[]
    @arr << "algo_examples"
  end
  if @e_code!=[] && @e_code!=nil
    puts @e_code
    @arr << "code"
  end
end
def algorithm_youtube(a)
      @youdoc = Nokogiri::HTML(open("http://www.youtube.com/results?search_query="+URI.encode(a.gsub(" ","+"))))
   @embed_vid = []
    j = 0
    while j < 5
      @embed_vid << @youdoc.css("h3.yt-lockup-title > a")[j].attributes["href"].value.split("=")[1]    
      j = j + 1
    end
    if @embed_vid
     @arr << "misc"
    end

end

def webpages_read(a)
  if !a.include?("http")
   a = "http://" + a
  end
  @src = a
  begin
    begin
      @y = DQReadability::Document.new(a,:tags=>%w[div pre p h1 h2 h3 h4 td table tr tt dl dd b a img br li ul ol center br hr blockquote em strong sub sup font tbody span],:attributes=>%w[href src align width color height]).content
    rescue
      source = URI.encode(a)
      @y = DQReadability::Document.new(source,:tags=>%w[div pre p h1 h2 h3 h4 td table tr tt dl dd b a img br li ul ol center br hr blockquote em strong sub sup font tbody span],:attributes=>%w[href src align width color height]).content
    end
  rescue
      source = URI.decode(a)
      @y = DQReadability::Document.new(source,:tags=>%w[div pre p h1 h2 h3 h4 td table tr tt dl dd b a img br li ul ol center br hr blockquote em strong sub sup font tbody span],:attributes=>%w[href src align width color height]).content
  end
  begin

  @y_title = Wikialgo.find_by("pages.link" =>a).pages.find_by("link"=>a).title
  rescue Exception => e  
  puts e.message  
  @y_title = "Article"
  end
  end
end