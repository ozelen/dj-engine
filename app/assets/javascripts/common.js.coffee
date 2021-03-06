$.ajaxSetup cache: false # work around Chrome not to show naked json on back/forward button

$ ->
  initComponents = ->
    $('.datepicker').datepicker
      dateFormat: 'dd.mm.yy'

  initComponents()

  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val '1'
    $(this).closest('fieldset').hide()
    event.preventDefault()


  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).closest('.row').before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
    initComponents()

  $(".carousel").carousel interval: 3200

  $("input.check_all").change ->
    control = $(this)
    control.closest('form').find(':checkbox').each ->
      $(this)[0].checked = control[0].checked

  $('.media-body.comment').click ->
    checkbox = $(this).find('input:checkbox[name="selected[]"]')[0]
    checkbox.checked = !checkbox.checked