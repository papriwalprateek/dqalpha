(function(){
  
  	// Actual content height, figured out by appending check the last element's document position.
  	function contentHeight( scrollable )
  	{
  		var overflowY = scrollable.getStyle( 'overflow-y' );
  
  		var doc = scrollable.getDocument();
  		// Create a temporary marker element.
  		var marker = CKEDITOR.dom.element.createFromHtml( '<span style="margin:0;padding:0;border:0;clear:both;width:1px;height:1px;display:block;">' + ( CKEDITOR.env.webkit ? ' ' : '' ) + '</span>', doc );
  		doc[ CKEDITOR.env.ie? 'getBody' : 'getDocumentElement']().append( marker );
  
  		var height = marker.getDocumentPosition( doc ).y + marker.$.offsetHeight;
  		marker.remove();
  		scrollable.setStyle( 'overflow-y', overflowY );
  		return height;
  	}
  
  	function getScrollable( editor )
  	{
  		var doc = editor.document,
  			body = doc.getBody(),
  			htmlElement = doc.getDocumentElement();
  
  		// Quirks mode overflows body, standards overflows document element
  		return doc.$.compatMode == 'BackCompat' ? body : htmlElement;
  	}
  
 	var resizeEditor = function( editor )
  	{
 		if ( !editor.window )
  			return;
  
  		var scrollable = getScrollable( editor ),
  			currentHeight = editor.window.getViewPaneSize().height,
  			newHeight = contentHeight( scrollable );
  
  		// Additional space specified by user.
  		newHeight += ( editor.config.autoGrow_bottomSpace || 0 );
  
  		var min = editor.config.autoGrow_minHeight != undefined ? editor.config.autoGrow_minHeight : 200,
  			max = editor.config.autoGrow_maxHeight || Infinity;
  
  		newHeight = Math.max( newHeight, min );
  		newHeight = Math.min( newHeight, max );
  
  		if ( newHeight != currentHeight )
  		{
  			newHeight = editor.fire( 'autoGrow', { currentHeight : currentHeight, newHeight : newHeight } ).newHeight;
  			editor.resize( editor.container.getStyle( 'width' ), newHeight, true );
  		}
  
  		if ( scrollable.$.scrollHeight > scrollable.$.clientHeight && newHeight < max )
  			scrollable.setStyle( 'overflow-y', 'hidden' );
  		else
  			scrollable.removeStyle( 'overflow-y' );
  
  
  	};
  
  	CKEDITOR.plugins.add( 'autogrow',
  	{
  		init : function( editor )
  		{
  			editor.addCommand( 'autogrow', { exec : resizeEditor, modes : { wysiwyg:1 }, readOnly: 1, canUndo: false, editorFocus: false } );
  
  			var eventsList = { contentDom:1, key:1, selectionChange:1, insertElement:1, mode:1 };
  			editor.config.autoGrow_onStartup && ( eventsList[ 'instanceReady' ] = 1 );
  			for ( var eventName in eventsList )
  			{
  				editor.on( eventName, function( evt )
  				{
  					var maximize = editor.getCommand( 'maximize' );
  					// Some time is required for insertHtml, and it gives other events better performance as well.
 					if ( evt.editor.mode == 'wysiwyg' &&
  						// Disable autogrow when the editor is maximized .(#6339)
  						( !maximize || maximize.state != CKEDITOR.TRISTATE_ON ) )
  					{
  						setTimeout( function()
  						{
  							resizeEditor( evt.editor );
  							// Second pass to make correction upon
  							// the first resize, e.g. scrollbar.
  							resizeEditor( evt.editor );
  						}, 100 );
  					}
  				});
  			}
  
  			// Coordinate with the "maximize" plugin. (#9311)
  			editor.on( 'beforeCommandExec', function( evt )
 			{
 				if ( evt.data.name == 'maximize' && evt.editor.mode == 'wysiwyg' )
 				{
 					if ( evt.data.command.state == CKEDITOR.TRISTATE_OFF )
 					{
 						var scrollable = getScrollable( editor );
 						scrollable.removeStyle( 'overflow' );
 					}
 					else
 						resizeEditor( editor );
 				}
 			});
 		}
 	});
 })();