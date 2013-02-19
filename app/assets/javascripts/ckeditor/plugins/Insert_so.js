CKEDITOR.plugins.add( 'Insert_so',
{
   
   init: function( editor )
   {
      
      editor.addCommand( 'insertInsert_so',
         {
            
            exec : function( editor )
            {    
                              
               editor.insertHtml( '!so[label](query)' );
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