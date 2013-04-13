CKEDITOR.plugins.add( 'Insert_wiki',
{
   
   init: function( editor )
   {
      
      editor.addCommand( 'insertInsert_wiki',
         {
            
            exec : function( editor )
            {    
                wiki_url_1 = prompt('Enter your Wikipedia query',"your query");
				var replace = " ";
				var re = new RegExp(replace, 'g');    
				wiki_url_1 = wiki_url_1.replace(re, '_');
               wiki_url = "/wik?ad="+wiki_url_1;
               editor.insertHtml( '<a id = "mashup_links" href='+wiki_url+'>'+wiki_url_1+'</a> ' );               
            }
         });
      
      editor.ui.addButton( 'Insert_wiki',
      {
         
         label: 'Insert wiki',
         
         command: 'insertInsert_wiki',
	
	icon: '/assets/wiki-button.png'
            } );
   }
} );