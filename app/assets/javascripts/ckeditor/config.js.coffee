CKEDITOR.editorConfig = (config) ->
  config.language = 'en'
  config.width = "90%"
  config.toolbar_Pure = [
    { name: 'styles',      items: [ 'Styles','Format','Font','FontSize' ] },
    { name: 'insert',      items: [ 'Image','Table','HorizontalRule' ] },
    { name: 'links',       items: [ 'Link','Insert_wiki','Insert_gist','Insert_so'] },
   '/',
    { name: 'basicstyles', items: [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
    { name: 'paragraph',   items: [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] }
    
  ]
  config.toolbar = 'Pure'
  config.extraPlugins = 'Insert_wiki,Insert_gist,Insert_so,autogrow' 
  config.toolbarStartupExpanded = false
  config.toolbarCanCollapse = true
  config.autoGrow_onStartup = true
  config.autoGrow_maxHeight = 800
  true