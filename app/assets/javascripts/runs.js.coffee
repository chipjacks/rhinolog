# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.best_in_place').best_in_place()

jQuery ->
  $('#run_date_text').datepicker
  	dateFormat: 'mm/dd'

# HTML code

comment_content = (content) ->
	'<textarea cols="10" id="run_comment" name="run[comment]" rows="5" 
					placeholder="Add comment">' + content + '</textarea>'

rhinoGrid = 
	'<div id="gridBox">
		<p id="feelText">FEEL</p>
		<div id="redsquare">
	    <span id="leftyellowsquare"></span>
	    <span id="leftgreensquare"></span>
	    <span id="bottomyellowsquare"></span>
	    <span id="bottomwhitesquare"></span>
	    <span id="bottomgreensquare"></span>
	    <p id="effortText">EFFORT</p>
		</div>
	</div>
	<div class="btn-group" id="gridfore" data-toggle="buttons-radio">
		<a class="btn btn-small gridButton gridCornerButton" id="1" href="#"><i class="icon-plus"></i></a>
		<a class="btn btn-small gridButton" id="2" href="#"><i class="icon-plus"></i></a>
		<a class="btn btn-small gridButton" id="3" href="#"><i class="icon-plus"></i></a>
		<br>
		<a class="btn btn-small gridButton" id="4" href="#"><i class="icon-plus"></i></a>
		<a class="btn btn-small gridButton" id="5" href="#"><i class="icon-plus"></i></a>
		<a class="btn btn-small gridButton" id="6" href="#"><i class="icon-plus"></i></a>
		<br>
		<a class="btn btn-small gridButton" id="7" href="#"><i class="icon-plus"></i></a>
		<a class="btn btn-small gridButton" id="8" href="#"><i class="icon-plus"></i></a>
		<a class="btn btn-small gridButton gridCornerButton" id="9" href="#"><i class="icon-plus"></i></a>
	</div>'

rhinoGridTemp =
	'<div class="popover gridInner">
		<div class="arrow"></div>
			<div class="popover-inner gridInner">
				<h3 class="popover-title"></h3>
				<div class="popover-content gridInner">
					<p></p>
	</div></div></div>'

# Oneline run form popovers

jQuery ->
 	$(".commentfield").popover({ trigger : 'manual', html : true, content : comment_content($('#hidcommfield').val()), placement : 'bottom' })

jQuery ->
	$(".commentfield").click ->
		$('.commentfield').data('popover').options.content = comment_content($('#hidcommfield').val());
		if $('#run_comment').length
			$('#hidcommfield').val($('#run_comment').val())
		$(this).popover('toggle') 	

jQuery ->
	$(".rhinoGrid").popover({ trigger : 'manual', placement : 'bottom', content : rhinoGrid, template: rhinoGridTemp })

activate = (num) ->
	$(".gridButton##{num}").addClass('active')

jQuery ->
	$(".rhinoGrid").click ->
		if $('.gridInner').length
			$('#hidGrid').val($('.gridButton.active').attr('id'))
			$(this).popover('toggle')
		else
			$(this).popover('toggle')
			activate($('#hidGrid').val())

jQuery ->
	$("#run-create-btn").click ->
		if $('.gridInner').length
			$('#hidGrid').val($('.gridButton.active').attr('id'))
		if $('#run_comment').length
			$('#hidcommfield').val($('#run_comment').val())

# Run comment tooltips

jQuery ->
	$(".comment-disp").tooltip({ placement : 'bottom' })

jQuery ->
	$(".deleteicon").tooltip({ placement : 'top' })

#Month view tooltips

jQuery ->
	$(".day_total").tooltip({ placement : 'top' })