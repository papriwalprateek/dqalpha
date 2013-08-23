$(function() {	

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
/*
 Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.md or http://ckeditor.com/license 
*/
(function(a){CKEDITOR.config.jqueryOverrideVal="undefined"==typeof CKEDITOR.config.jqueryOverrideVal?!0:CKEDITOR.config.jqueryOverrideVal;"undefined"!=typeof a&&(a.extend(a.fn,{ckeditorGet:function(){var a=this.eq(0).data("ckeditorInstance");if(!a)throw"CKEditor is not initialized yet, use ckeditor() with a callback.";return a},ckeditor:function(g,d){if(!CKEDITOR.env.isCompatible)throw Error("The environment is incompatible.");if(!a.isFunction(g))var k=d,d=g,g=k;var i=[],d=d||{};this.each(function(){var b=
a(this),c=b.data("ckeditorInstance"),f=b.data("_ckeditorInstanceLock"),h=this,j=new a.Deferred;i.push(j.promise());if(c&&!f)g&&g.apply(c,[this]),j.resolve();else if(f)c.once("instanceReady",function(){setTimeout(function(){c.element?(c.element.$==h&&g&&g.apply(c,[h]),j.resolve()):setTimeout(arguments.callee,100)},0)},null,null,9999);else{if(d.autoUpdateElement||"undefined"==typeof d.autoUpdateElement&&CKEDITOR.config.autoUpdateElement)d.autoUpdateElementJquery=!0;d.autoUpdateElement=!1;b.data("_ckeditorInstanceLock",
!0);c=a(this).is("textarea")?CKEDITOR.replace(h,d):CKEDITOR.inline(h,d);b.data("ckeditorInstance",c);c.on("instanceReady",function(d){var e=d.editor;setTimeout(function(){if(e.element){d.removeListener();e.on("dataReady",function(){b.trigger("dataReady.ckeditor",[e])});e.on("setData",function(a){b.trigger("setData.ckeditor",[e,a.data])});e.on("getData",function(a){b.trigger("getData.ckeditor",[e,a.data])},999);e.on("destroy",function(){b.trigger("destroy.ckeditor",[e])});e.on("save",function(){a(h.form).submit();
return!1},null,null,20);if(e.config.autoUpdateElementJquery&&b.is("textarea")&&a(h.form).length){var c=function(){b.ckeditor(function(){e.updateElement()})};a(h.form).submit(c);a(h.form).bind("form-pre-serialize",c);b.bind("destroy.ckeditor",function(){a(h.form).unbind("submit",c);a(h.form).unbind("form-pre-serialize",c)})}e.on("destroy",function(){b.removeData("ckeditorInstance")});b.removeData("_ckeditorInstanceLock");b.trigger("instanceReady.ckeditor",[e]);g&&g.apply(e,[h]);j.resolve()}else setTimeout(arguments.callee,
100)},0)},null,null,9999)}});var f=new a.Deferred;this.promise=f.promise();a.when.apply(this,i).then(function(){f.resolve()});this.editor=this.eq(0).data("ckeditorInstance");return this}}),CKEDITOR.config.jqueryOverrideVal&&(a.fn.val=CKEDITOR.tools.override(a.fn.val,function(g){return function(d){if(arguments.length){var k=this,i=[],f=this.each(function(){var b=a(this),c=b.data("ckeditorInstance");if(b.is("textarea")&&c){var f=new a.Deferred;c.setData(d,function(){f.resolve()});i.push(f.promise());
return!0}return g.call(b,d)});if(i.length){var b=new a.Deferred;a.when.apply(this,i).done(function(){b.resolveWith(k)});return b.promise()}return f}var f=a(this).eq(0),c=f.data("ckeditorInstance");return f.is("textarea")&&c?c.getData():g.call(f)}})))})(window.jQuery);