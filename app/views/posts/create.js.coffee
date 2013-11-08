$('#posts').prepend('<%= escape_javascript render(@post) %>')
$('#form_post').hide();
$('#new_post_link').show();
$('#new_post textarea').each -> $(this).val('')
$('#new_post input:text').each -> $(this).val('')
$('#new_post input:checkbox').each -> $(this).attr('checked', false)