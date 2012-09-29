# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.best_in_place').best_in_place()

jQuery ->
  $('#run_date_text').datepicker
  	dateFormat: 'mm/dd'

# HTML code

notes_content = (content) ->
	'<textarea cols="10" id="run_notes" name="run[notes]" rows="5" 
					placeholder="Add note">' + content + '</textarea>'

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
		<a class="btn btn-small gridButton gridCornerButton" id="1" title="Easy, Bad" href="#"><i class="icon-nil"></i></a>
		<a class="btn btn-small gridButton" id="2" title="Moderate, Bad" href="#"><i class="icon-nil"></i></a>
		<a class="btn btn-small gridButton" id="3" title="Hard, Bad" href="#"><i class="icon-nil"></i></a>
		<br>
		<a class="btn btn-small gridButton" id="4" title="Easy, Okay" href="#" rel="tooltip"><i class="icon-nil"></i></a>
		<a class="btn btn-small gridButton" id="5" title="Moderate, Okay" href="#"><i class="icon-nil"></i></a>
		<a class="btn btn-small gridButton" id="6" title="Hard, Okay" href="#"><i class="icon-nil"></i></a>
		<br>
		<a class="btn btn-small gridButton" id="7" title="Easy, Good" href="#"><i class="icon-nil"></i></a>
		<a class="btn btn-small gridButton" id="8" title="Moderate, Good" href="#"><i class="icon-nil"></i></a>
		<a class="btn btn-small gridButton gridCornerButton" id="9" title="Hard, Good" href="#"><i class="icon-nil"></i></a>
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
 	$(".notesfield").popover({ trigger : 'manual', html : true, content : notes_content($('#hidnotefield').val()), placement : 'bottom' })

jQuery ->
	$(".notesfield").click ->
		$('.notesfield').data('popover').options.content = notes_content($('#hidnotefield').val());
		if $('#run_notes').length
			$('#hidnotefield').val($('#run_notes').val())
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
			$(".gridButton").tooltip({ placement : 'top', delay: { show: 400, hide: 0 } })
			activate($('#hidGrid').val())
	

jQuery ->
	$("#run-create-btn").click ->
		if $('.gridInner').length
			$('#hidGrid').val($('.gridButton.active').attr('id'))
		if $('#run_notes').length
			$('#hidnotefield').val($('#run_notes').val())

jQuery ->
	$(".hint_tooltip").tooltip({ trigger: 'focus', placement : 'top' })
	

# Run notes tooltips

jQuery ->
	$(".notes-disp").tooltip({ placement : 'bottom' })

jQuery ->
	$(".deleteicon").tooltip({ placement : 'top' })

#Month view tooltips

jQuery ->
	$(".feel").tooltip({ placement : 'right' })

jQuery ->
	$(".effort").tooltip({ placement : 'left' })