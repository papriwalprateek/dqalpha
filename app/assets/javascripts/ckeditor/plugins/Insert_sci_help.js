CKEDITOR.plugins.add( 'Insert_sci_help',
{
   
   init: function( editor )
   {
      
      editor.addCommand( 'insertInsert_sci',
         {
            
            exec : function( editor )
            {    
                sci_url = prompt('Enter your Wikipedia query',"your query");
				var replace = " ";
				var re = new RegExp(replace, 'g');    
				sci_url = sci_url.replace(re, '_');
               sci_url = "/scilab?ad="+sci_url;
               editor.insertHtml( '<a id = "mashup_links" href='+sci_url+'>here</a> ' );               
            }
         });
      
      editor.ui.addButton( 'Insert_sci_help',
      {
         
         label: 'Insert Scilab help tag',
         
         command: 'insertInsert_sci',
	
	icon: '/assets/sci-button.png'
            } );
   }
} );