# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# jQuery ->
#   $('#run_date_text').datepicker
#   	dateFormat: 'mm/dd'

# # HTML code

# notes_content = (content) ->
# 	'<textarea cols="10" id="run_notes" name="run[notes]" rows="5" 
# 					placeholder="Add note">' + content + '</textarea>'

# rhinoGrid = 
# 	'<div id="gridBox">
# 		<p id="feelText">FEEL</p>
# 		<div id="redsquare">
# 	    <span id="leftyellowsquare"></span>
# 	    <span id="leftgreensquare"></span>
# 	    <span id="bottomyellowsquare"></span>
# 	    <span id="bottomwhitesquare"></span>
# 	    <span id="bottomgreensquare"></span>
# 	    <p id="effortText">EFFORT</p>
# 		</div>
# 	</div>
# 	<div class="btn-group" id="gridfore" data-toggle="buttons-radio">
# 		<a class="btn btn-small gridButton gridCornerButton" id="1" title="Easy, Bad" href="#"><i class="icon-nil"></i></a>
# 		<a class="btn btn-small gridButton" id="2" title="Moderate, Bad" href="#"><i class="icon-nil"></i></a>
# 		<a class="btn btn-small gridButton" id="3" title="Hard, Bad" href="#"><i class="icon-nil"></i></a>
# 		<br>
# 		<a class="btn btn-small gridButton" id="4" title="Easy, Okay" href="#" rel="tooltip"><i class="icon-nil"></i></a>
# 		<a class="btn btn-small gridButton" id="5" title="Moderate, Okay" href="#"><i class="icon-nil"></i></a>
# 		<a class="btn btn-small gridButton" id="6" title="Hard, Okay" href="#"><i class="icon-nil"></i></a>
# 		<br>
# 		<a class="btn btn-small gridButton" id="7" title="Easy, Good" href="#"><i class="icon-nil"></i></a>
# 		<a class="btn btn-small gridButton" id="8" title="Moderate, Good" href="#"><i class="icon-nil"></i></a>
# 		<a class="btn btn-small gridButton gridCornerButton" id="9" title="Hard, Good" href="#"><i class="icon-nil"></i></a>
# 	</div>'

# rhinoGridTemp =
# 	'<div class="popover gridInner">
# 		<div class="arrow"></div>
# 			<div class="popover-inner gridInner">
# 				<h3 class="popover-title"></h3>
# 				<div class="popover-content gridInner">
# 					<p></p>
# 	</div></div></div>'

# # Oneline run form popovers

# jQuery ->
#  	$(".notesfield").popover({ trigger : 'manual', html : true, content : notes_content($('#hidnotefield').val()), placement : 'bottom' })

# jQuery ->
# 	$(".notesfield").click ->
# 		$('.notesfield').data('popover').options.content = notes_content($('#hidnotefield').val());
# 		if $('#run_notes').length
# 			$('#hidnotefield').val($('#run_notes').val())
# 		$(this).popover('toggle') 	

# jQuery ->
# 	$(".rhinoGrid").popover({ trigger : 'manual', placement : 'bottom', content : rhinoGrid, template: rhinoGridTemp })

# activate = (num) ->
# 	$(".gridButton##{num}").addClass('active')

# jQuery ->
# 	$(".rhinoGrid").click ->
# 		if $('.gridInner').length
# 			$('#hidGrid').val($('.gridButton.active').attr('id'))
# 			$(this).popover('toggle')
# 		else
# 			$(this).popover('toggle')
# 			$(".gridButton").tooltip({ placement : 'top', delay: { show: 400, hide: 0 } })
# 			activate($('#hidGrid').val())
	

# jQuery ->
# 	$("#run-create-btn").click ->
# 		if $('.gridInner').length
# 			$('#hidGrid').val($('.gridButton.active').attr('id'))
# 		if $('#run_notes').length
# 			$('#hidnotefield').val($('#run_notes').val())

# jQuery ->
# 	$(".hint_tooltip").tooltip({ trigger: 'focus', placement : 'top' })
	

# Summary view
jQuery ->
	$(".notes-disp").tooltip({ placement : 'bottom' })

jQuery ->
  $('.goto_date').datepicker(
    dateFormat: 'yy-mm-dd'
    changeMonth: true
    changeYear: true
    constrainInput: true
  )

jQuery ->
	$('.goto_date').change ->
		$('#goto_date').attr('href', "/summary?date=" + $(this).val())

# Run notes tooltips

jQuery ->
	$(".notes-disp").tooltip({ placement : 'bottom' })

jQuery ->
	$(".runicon").tooltip({ placement : 'top' })

# Month view tooltips

jQuery ->
	$(".feel").tooltip({ placement : 'right' })

jQuery ->
	$(".effort").tooltip({ placement : 'left' })

#Run Edit Modal

jQuery ->
	$('.newrun').click ->
		$('#runModal').modal('show')
		$('#run_date_text').val($(this).attr('data-date'))

jQuery ->
	$('.icon-plus').click ->
		$('#runModal').modal('show')
		$('#run_date_text').val($(this).attr('data-date'))

fill_in = (JSON) ->
	$('#run_date_text').val(JSON['date'])
	$('#run_distance').val(JSON['distance'])
	if JSON['time_in_secs']
		$('#time_mins').val(Math.round(parseInt(JSON['time_in_secs'])/60))
	if not JSON['pace_text']
	else if JSON['pace_text'].length == 4
		pace_secs = parseInt(JSON['pace_text'][2..3])
		pace_mins = parseInt(JSON['pace_text'][0])
	else if JSON['pace_text'].length == 5
		pace_secs = parseInt(JSON['pace_text'][3..4])
		pace_mins = parseInt(JSON['pace_text'][0..1])
	if pace_secs < 10
		pace_secs = '0' + pace_secs
	$('#pace_mins').val(pace_mins)
	$('#pace_secs').val(pace_secs)
	$('#run_notes_field').val(JSON['notes'])
	$("button[data-feel=" + JSON['feel'] + "]").addClass('active')
	$("button[data-effort=" + JSON['effort'] + "]").addClass('active')

gen_form = (JSON, run_id) ->
	$('#new_run').attr('action', '/runs/' + run_id)
	fill_in(JSON)

jQuery ->
	$('.editrun').click (e) ->
		if $(e.target).hasClass('runicon')
			return
		$('#runModal').modal('show')
		$('#runModalLabel').text('Edit Run')
		run_id = $(this).attr('data-id')
		$('#run-create-btn').attr('data-id', run_id)
		load_url = 'runs/' + run_id
		$.getJSON(load_url, (JSON) ->
			gen_form(JSON, run_id)
		)

update_pace = (dist, tm) ->
	tt = tm*60
	pace_secs = Math.round(tt/dist)
	pace_mins = Math.floor(pace_secs/60)
	pace_secs %= 60
	if pace_secs < 10
		$('#pace_secs').val('0' + pace_secs)
	else
		$('#pace_secs').val(pace_secs)
	$('#pace_mins').val(pace_mins)
	$('#pace_mins').parent().removeClass('error')

update_time = (dist, pm, ps) ->
	pt = pm*60 + ps
	time_secs = dist*pt
	time_mins = Math.round(time_secs/60)
	$('#time_mins').val(time_mins)
	$('#time_mins').parent().removeClass('error')

update_dist = (tm, pm, ps) ->
	tt = tm*60
	pt = pm*60 + ps
	dist = Math.round(tt/pt)
	$('#run_distance').val(dist)
	$('#run_distance').parent().removeClass('error')

jQuery ->
	$('.runform_input').blur ->
		data = $('.runform_input').serializeArray()
		dist = parseFloat(data[0].value)
		time_mins = parseFloat(data[1].value)
		pace_mins = parseInt(data[2].value)
		pace_secs = parseInt(data[3].value)
		if $(this).attr('name') == 'run[distance]'
			if time_mins and dist
				update_pace(dist, time_mins)
			else if dist and pace_mins and (pace_secs or pace_secs == 0)
				update_time(dist, pace_mins, pace_secs)
		else if $(this).attr('id') == 'time_mins'
			if dist and time_mins
				update_pace(dist, time_mins)
			else if time_mins and pace_mins and (pace_secs or pace_secs == 0)
				update_dist(time_mins, pace_mins, pace_secs)
		else
			if dist and pace_mins and (pace_secs or pace_secs == 0)
				update_time(dist, pace_mins, pace_secs)
			else if time_mins and pace_mins and pace_secs
				update_dist(time_mins, pace_mins, pace_secs)

jQuery ->
	$('.runform_input').change ->
		if isNaN($(this).val()/1) and $(this).val.length > 0
			$(this).parent().addClass('error')
		else
			$(this).parent().removeClass('error')

update_hid_fields = ->
	unless $('#time_mins').parent().hasClass('error')
		mins = parseFloat($('#time_mins').val())
		$('#run_time_in_secs').val(Math.round(mins*60))
	unless $('#pace_mins').parent().hasClass('error')
		mins = parseInt($('#pace_mins').val())
		secs = parseInt($('#pace_secs').val())
		$('#run_pace_in_secs').val(mins*60 + secs)
	if $('#run_distance').parent().hasClass('error')
		$('#run_date_text').val('')
	$('#run_feel').val($('#feel > .active').attr('data-feel'))
	$('#run_effort').val($('#effort > .active').attr('data-effort'))

jQuery ->
	$('#run-create-btn').click ->
		update_hid_fields()

clear_fields = ->
	$('#new_run').attr('action', '')
	$('#run_date_text').val('')
	$('#run_distance').val('')
	$('#time_mins').val('')
	$('#pace_mins').val('')
	$('#pace_secs').val('')
	$('#run_notes_field').val('')
	$('#feel > .active').removeClass('active')
	$('#effort > .active').removeClass('active')

jQuery ->
	$('#runModal').on('show', ->
  	clear_fields()
  )

#placeholder fix for ie

jQuery ->
	`$(function() {
		var input = document.createElement("input");
	    if(('placeholder' in input)==false) { 
			$('[placeholder]').focus(function() {
				var i = $(this);
				if(i.val() == i.attr('placeholder')) {
					i.val('').removeClass('placeholder');
					if(i.hasClass('password')) {
						i.removeClass('password');
						this.type='password';
					}			
				}
			}).blur(function() {
				var i = $(this);	
				if(i.val() == '' || i.val() == i.attr('placeholder')) {
					if(this.type=='password') {
						i.addClass('password');
						this.type='text';
					}
					i.addClass('placeholder').val(i.attr('placeholder'));
				}
			}).blur().parents('form').submit(function() {
				$(this).find('[placeholder]').each(function() {
					var i = $(this);
					if(i.val() == i.attr('placeholder'))
						i.val('');
				})
			});
		}
	});`