$('.hotel-item .distance').tooltip()

$('.hotel-item .periods .dropdown-menu li').click ->
  self = $(this)
  container = self.closest('.btn-group')
  self.addClass("active").siblings().removeClass("active")
  container.find('button').html(self.html())
  $('.price.'+self.attr('id')).show().siblings().hide()
  return false