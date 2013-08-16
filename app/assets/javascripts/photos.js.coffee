
jQuery ->
  data = $('#new_photo').serializeArray()
  console.log data
  $('#new_photo').fileupload
      dataType: "script"
      paramName: 'photo[image]'
      formData: data
      progressall: (e, data) ->
        progress = parseInt(data.loaded / data.total * 100, 10)
        $('#progress .bar').css(
            'width',
            progress + '%'
        ).find('.sr-only').html(progress + '%')
