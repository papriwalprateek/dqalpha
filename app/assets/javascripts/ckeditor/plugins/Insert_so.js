CKEDITOR.plugins.add( 'Insert_so',
{
   
   init: function( editor )
   {
      
      editor.addCommand( 'insertInsert_so',
         {
            
            exec : function( editor )
            {    
               so_url_1 = prompt('Enter your Stack Overflow url');
               so_url = "/so?ad="+so_url_1;
               editor.insertHtml( '<a id = "mashup_links" href='+so_url+'>'+so_url_1+'</a> ' );
            }
         });
      
      editor.ui.addButton( 'Insert_so',
      {
         
         label: 'Insert so',
         
         command: 'insertInsert_so',
	icon: '/assets/so-button.png'
            } );
   }
} );