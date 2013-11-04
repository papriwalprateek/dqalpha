$(function() {	
//youtube like progress bar
hide_rightcontent();
$(document).ajaxStart(function() {
    //only add progress bar if added yet.
    if ($("#progress").length === 0) {
        $("body").append($("<div><dt/><dd/></div>").attr("id", "progress"));
        $("#progress").width((50 + Math.random() * 30) + "%");
    }
});

$(document).ajaxComplete(function() {
    //End loading animation
    $("#progress").width("101%").delay(200).fadeOut(400, function() {
        $(this).remove();
    });
});
//new quest text fields
 
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
   $("div.sci_rel_func a.link").live("click", function() {
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
function edit_this_qmail(elem,q_idd,qmail_idd){
var editable = $(elem).parents('div.post')[0];
var content = $(editable).children("div.c_qmail");
var form_url = '/qs/'+q_idd;
var form_urll = form_url+'/qmails/'+qmail_idd+'/update';
$form = $('<form action='+form_urll+' method="post" data-remote ="true"></form>');
$form.append('<textarea name ="qmail_content_edit"/>');

$form.append('<input class="qmail_submit" type="submit" value="Save it!" >');
($form).insertBefore(content);
$($form).children("textarea").ckeditor();
CKEDITOR.instances.qmail_content_edit.setData($(content).html());
$('button.edit_qmail').hide();
$(content).hide();
$(editable).append('<a href='+form_url+' class="live_link">Cancel</a>');
}
function show_rightcontent(){
 $('div#rightcontent').show();
 $('div#content').css("width", "65%");	
 $('div.dashboard_right').css("width", "20%");	
}
function hide_rightcontent(){
 $('div#rightcontent').hide();
 $('div#content').css("width", "100%");	
 $('div.dashboard_right').css("width", "13%");	
}
function toggle_rightcontent(){
	if($('div#rightcontent').css('display')=="none") show_rightcontent();
	else hide_rightcontent();
}
