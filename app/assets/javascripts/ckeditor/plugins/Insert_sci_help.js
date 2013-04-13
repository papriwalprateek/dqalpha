CKEDITOR.plugins.add( 'Insert_sci_help',
{
   
   init: function( editor )
   {
      
      editor.addCommand( 'insertInsert_sci',
         {
            
            exec : function( editor )
            {    
                sci_url_1 = prompt('Enter your Wikipedia query',"your query");
				var replace = " ";
				var re = new RegExp(replace, 'g');    
				sci_url_1 = sci_url_1.replace(re, '_');
               sci_url = "/scilab?ad="+sci_url_1;
               editor.insertHtml( '<a id = "mashup_links" href='+sci_url+'>'+sci_url_1+'</a> ' );               
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