
jQuery ->
  $('#new_photo').fileupload
      dataType: "script"
      paramName: 'photo[image]'
      progressall: (e, data) ->
        progress = parseInt(data.loaded / data.total * 100, 10)
        $('#progress .bar').css(
            'width',
            progress + '%'
        ).find('.sr-only').html(progress + '%')
