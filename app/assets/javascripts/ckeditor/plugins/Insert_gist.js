CKEDITOR.plugins.add( 'Insert_gist',
{
   
   init: function( editor )
   {
      
      editor.addCommand( 'insertInsert_gist',
         {
            
            exec : function( editor )
            {    
               gist_url = prompt('Enter your gist id ');
               editor.insertHtml( '<a id = "mashup_links" href='+gist_url+'>here</a> ' ); 
            }
         });
      
      editor.ui.addButton( 'Insert_gist',
      {
         
         label: 'Insert gist',
         
         command: 'insertInsert_gist',
	icon: '/assets/gist-button.png'
            } );
   }
} );