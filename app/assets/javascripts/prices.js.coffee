
$ ->
  refresh_header = (obj) ->
    panel = $(obj).closest('.period-panel')
    header = panel.find('.panel-heading h3')
    val = (name) -> panel.find('.period-' + name).val()
    str = val('since') + ' - ' + val('till') + ' ' + val('name')
    header.html(str)

  $(document).on 'change', '.period-panel .period-values input', ->
    refresh_header(this)



