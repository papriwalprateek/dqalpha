CKEDITOR.plugins.add( 'Insert_wiki',
{
   
   init: function( editor )
   {
      
      editor.addCommand( 'insertInsert_wiki',
         {
            
            exec : function( editor )
            {    
                              
               editor.insertHtml( '!wiki[label](query)' );
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