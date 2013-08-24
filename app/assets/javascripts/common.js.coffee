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