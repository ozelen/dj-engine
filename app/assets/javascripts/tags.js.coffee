
$('.checktags').on 'change', '.tag-checkboxes input[type=checkbox]', ->
  checkbox = $(this)
  container = checkbox.closest('.tag-checkboxes')
  tags_array = []

  container.find('input[type=checkbox]:checked').each ->
    tags_array.push $(this).val()

  container.find('input[type=hidden]').val(tags_array.join(', '))