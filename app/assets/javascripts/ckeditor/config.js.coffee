CKEDITOR.editorConfig = (config) ->
  config.language = 'en'
  config.width = "90%"
  config.toolbar_Pure = [
    { name: 'styles',      items: [ 'Styles','Format','Font','FontSize' ] },
    { name: 'paragraph',   items: [ 'NumberedList','BulletedList','-','-','Blockquote','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-'] }
      
   '/',
    { name: 'basicstyles', items: [ 'Bold','Italic','Underline','-','RemoveFormat' ] },
    { name: 'insert',      items: [ 'Image','Link','Insert_wiki','Insert_gist','Insert_so','Insert_sci_help'] },
  
  ]
  config.toolbar = 'Pure'
  config.extraPlugins = 'Insert_wiki,Insert_gist,Insert_so,Insert_sci_help,autogrow' 
  config.toolbarStartupExpanded = false
  config.toolbarCanCollapse = false
  config.autoGrow_onStartup = true
  config.autoGrow_maxHeight = 800
  true

