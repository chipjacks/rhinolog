# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.best_in_place').best_in_place()

jQuery ->
  $('#run_date').datepicker
  	dateFormat: 'yy-mm-dd'

comment_content = (content) ->
	"<textarea cols=\"10\" id=\"run_comment\" name=\"run[comment]\" rows=\"5\" placeholder=\"Add comment\">#{content}</textarea>"

cont = ''

jQuery ->
	$(".commentfield").click ->
		$('.commentfield').data('popover').options.content = comment_content($('#hidcommfield').val());
		if $('#run_comment').length
			$('#hidcommfield').val($('#run_comment').val())
		$(this).popover('toggle')

jQuery ->
 	$(".commentfield").popover({ trigger : 'manual', html : true, content : comment_content($('#hidcommfield').val()), placement : 'bottom' })

jQuery ->
	$(".comment-disp").tooltip({ placement : 'bottom' })