$(function() {	

//new quest text fields
 alert("asd");
       $("textarea#quest_description").blur(function() {
        if ($(this).val() == "") {
            $(this).val("Provide a description");
            
        }
    }).focus(function() {
        if ($(this).val() == "Provide a description") {
            $(this).val("");
              
        }
    });
      $("input#quest_title").blur(function() {
        if ($(this).val() == "") {
            $(this).val("A name for the Quest");
              
        }
    }).focus(function() {
        if ($(this).val() == "A name for the Quest") {
            $(this).val("");
              
        }
    });

//new q text field

 

	//for wiki selection
    	 $(document.body).bind('mouseup', function(e){
        var selection;
        
        if (window.getSelection) {
          selection = window.getSelection();
          
        } else if (document.selection) {
          selection = document.selection.createRange();
        }
         var mousePos;
         mousePos = {left: e.pageX , top: e.pageY};   
        
        if(selection.toString() != ''&& !$("#onselection_list").is(":visible")) {
            
            $('#onselection_list').css("position","fixed");
            $('#onselection_list').css("top",mousePos.top);
            $('#onselection_list').css("left",mousePos.left);
            $('#onselection_list p').html(selection.toString());
            $('#onselection_list').show();
            $("#onselection_list button").show();   
    		
        
        } 
        else if(selection.toString()!=""){
            
        }
        else {
            	 $('#onselection_list p').html("");
        
            $('#onselection_list').hide();
        }
    });
     	
 //git browse repo
   $("a.live_link").live("click", function() {
    $.getScript(this.href);
    window.history.pushState(null, document.title, this.href);
     return false;
  });

  $(".content_middle a").live("click", function() {
    $.getScript(this.href);
    window.history.pushState(null, document.title, this.href);
     return false;
  });
 
  $("#leftcontent a").live("click", function() {
    $.getScript(this.href);
    window.history.pushState(null, document.title, this.href);
     return false;
  });
  $("#q text.grey a").live("click", function() {
    $.getScript(this.href);
    window.history.pushState(null, document.title, this.href);
     return false;
  });
  $(".live_links_right a,a#mashup_links").live("click", function() {
      $.ajax({
			type: "GET",
			url: this.href,
		   beforeSend: function() {
              $("#loading-image").show();
               $("#loading-fail").hide();
  
           },
           success: function() {
              $("#loading-image").hide();
           },
           error: function() {
              $("#loading-fail").show();  
              $("#loading-image").hide();
               
           }
		});
     return false;
 });
 
  
  
   $(window).bind("popstate", function() {
      $.getScript(location.href);
    });

  if ($("#com").length > 0) {
    setTimeout(updateComments, 100000);
  }
	
	});
function updateComments () {
  var q_id = $("#q").attr("data-id");
  if ($(".post").length > 0) {
    var after = $(".post:last-child").attr("data-time");
  } else {
    var after = "0";
  }
  $.getScript("/qs/"+ q_id +"/qmails.js?q_id=" + q_id + "&after=" + after)
  setTimeout(updateComments, 100000);
}

//send for search to wiki
    	function search_wiki () {
    		 var selection;
        
        if (window.getSelection) {
          selection = window.getSelection();
          
        } else if (document.selection) {
          selection = document.selection.createRange();
        }
        
    		   $.getScript("/wik?ad="+selection.toString());
    		  	 $('#onselection_list button').hide(400,function(){   $( "#onselection_list" ).animate({
  				left: 50, opacity: 1,
    	
          	top:  $("#rightcontent").position().top,
    		   	left:$("#rightcontent").position().left
    		    
			}, 800 );});
        
    		 
			$("#link_1").click();
    	     
    	}
