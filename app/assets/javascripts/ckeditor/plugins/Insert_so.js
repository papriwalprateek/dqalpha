CKEDITOR.plugins.add( 'Insert_so',
{
   
   init: function( editor )
   {
      
      editor.addCommand( 'insertInsert_so',
         {
            
            exec : function( editor )
            {    
               so_url = prompt('Enter your Stack Overflow url');
               so_url = "/so?ad="+so_url;
               editor.insertHtml( '<a href='+so_url+'>here</a> ' );
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