$ ->
  $('.amenity').each ->
    $(this).closest('.form-group').appendTo(
        $('#field_category_'+$(this).attr('category_id'))
    )

