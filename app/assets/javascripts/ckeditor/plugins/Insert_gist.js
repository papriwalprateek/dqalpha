CKEDITOR.plugins.add( 'Insert_gist',
{
   
   init: function( editor )
   {
      
      editor.addCommand( 'insertInsert_gist',
         {
            
            exec : function( editor )
            {    
                              
               editor.insertHtml( '!gist[label](query)' );
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