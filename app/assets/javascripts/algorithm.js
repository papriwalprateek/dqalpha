// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-migrate
//= require jquery-ujs
//= require highlight.pack
//= require jquery-ui
$(function() {	
//youtube like progress bar

$(document).ajaxStart(function() {
    //only add progress bar if added yet.
    if ($("#progress").length === 0) {
        $("body").append($("<div><dt/><dd/></div>").attr("id", "progress"));
        $("#progress").width((50 + Math.random() * 30) + "%");
    }
    console.log(location.href);
});

$(document).ajaxComplete(function() {
    //End loading animation
    $("#progress").width("101%").delay(200).fadeOut(400, function() {
        $(this).remove();
    });
});
$(document).ajaxSend(function(evt, request, settings) {
 if(settings.url.split("/search?")[1]!=undefined){
    $('p.searching_text').show();
  }
});
  //git browse repo
   $("a.live_link").live("click", function() {
    $.getScript(this.href);
    window.history.pushState(null, document.title, this.href);
     return false;
  }); 
  $("div#algo_related a").live("click", function() {
    $.getScript(this.href);
    window.history.pushState(null, document.title, this.href);
     return false;
  });
  $("div#qna div.result-link a").live("click", function() {
     a = this.href;
     b = a.split("questions/")[1];
     b = b.split("/")[0];
     ajax_result_content_navigation("/so","stackoverflow.com/questions/"+b);
     return false;
   });
   
  $("a.geeks_link").live("click", function() {
     a = this.href.split("geeks-link/")[1];
     ajax_result_content_navigation("/geeks-link","geeksforgeeks.org/"+a);
     return false;
   });

	
	});

function ajax_result_content_navigation(url,data){
	$('div.quest_search_page').children().hide();
	 $('div.quest_search_page').append('<div id="result_content_navigation"style="margin-top:5px;;width: 70%;display: inline-block;"><button id="navi_result" onclick=back_navigation()>Back</button></div>');
          $.ajax({
			type: "GET",
			url: url,
			data: { ad: data,right: false}
		  });
}
function back_navigation(){
	$('div#result_content_navigation').remove();
	$('div.quest_search_page').children().show();
	$('div.quest_search_page .vm_results').hide();
	$('div.quest_search_page #'+vm_live_id).show();
}
	_gaq.push(['_setDomainName', '.daqwest.com']);
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-45960569-1', 'daqwest.com');
  ga('send', 'pageview');

