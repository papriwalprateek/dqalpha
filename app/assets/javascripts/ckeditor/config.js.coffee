CKEDITOR.editorConfig = (config) ->
  config.language = 'en'
  config.width = "90%"
  config.toolbar_Pure = [
    { name: 'styles',      items: [ 'Styles','Format','Font','FontSize' ] },
    { name: 'insert',      items: [ 'Image','Table','HorizontalRule' ] },
    { name: 'links',       items: [ 'Link'] },
   '/',
    { name: 'basicstyles', items: [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
    { name: 'paragraph',   items: [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] }
    
  ]
  config.toolbar = 'Pure'
  true