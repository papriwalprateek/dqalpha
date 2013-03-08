CKEDITOR.plugins.add( 'Insert_wiki',
{
   
   init: function( editor )
   {
      
      editor.addCommand( 'insertInsert_wiki',
         {
            
            exec : function( editor )
            {    
                wiki_url = prompt('Enter your Wikipedia query',"your query");
				var replace = " ";
				var re = new RegExp(replace, 'g');    
				wiki_url = wiki_url.replace(re, '_');
               wiki_url = "/wik?ad="+wiki_url;
               editor.insertHtml( '<a id = "mashup_links" href='+wiki_url+'>here</a> ' );               
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