#= require includes/open_close_icon

$(document).on "page:change", ->
  if editorNode = $('#editor')[0]
    editor = ace.edit('editor')
    editor.setReadOnly(true)
    editor.setTheme("ace/theme/solarized_dark")
    editor.getSession().setMode("ace/mode/dockerfile")

  $('body').on('click', '.btn-edit-role', (event) ->
    el = $(this).find('i.fa')
    if $(this).hasClass('button_dockerfile')
      editor = ace.edit('editor')
      editor.setReadOnly(!editor.getReadOnly())
      open_close_icon(el)
      $('#change_dockerfile_' + event.currentTarget.value).toggle()
  )

  $('button[type="submit"]').on 'click', (event) ->
    event.preventDefault()
    form = $(event.currentTarget).parents('form')
    editor = ace.edit('editor')
    dockerfile = editor.getValue()
    form.find('#image_dockerfile').val(dockerfile)
    $(event.currentTarget).parents('form').submit()
