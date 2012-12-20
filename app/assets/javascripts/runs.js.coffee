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
	

# Run notes tooltips

jQuery ->
	$(".deleteicon").tooltip({ placement : 'top' })

jQuery ->
	$('.newrun').click ->
		$('#runModal').modal('show')
		$('#run_date_text').val($(this).attr('data-date'))

fill_in = (JSON) ->
	$('#run_date_text').val(JSON['date'])
	$('#run_distance').val(JSON['distance'])
	$('#run_time_text').val(JSON['time_text'])
	$('#run_pace_text').val(JSON['pace_text'])
	$('#run_notes_field').val(JSON['notes'])

gen_form = (JSON) ->
	$('#new_run').attr('method', 'put')
	$('#new_run').attr('action', '/runs/' + JSON['id'])
	$('#new_run').attr('data-remote', 'true')
	$('#new_run').attr('data-type', 'json')
	fill_in(JSON)

	#replaceWith('<form method="put" id="edit_run" class="form_inline" action="/runs/"'
	#	+ JSON['id'] + 'accept-charset="UTF-8"></form>')

jQuery ->
	$('.editrun').click ->
		$('#runModal').modal('show')
		$('#runModalLabel').text('Edit Run')
		run_id = $(this).attr('data-id')
		$('#run-create-btn').attr('data-id', run_id)
		load_url = 'runs/' + run_id
		$.getJSON(load_url, (JSON) ->
			gen_form(JSON)
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
	if pace_mins < 10
		$('#pace_mins').val('  ' + pace_mins)
	else
		$('#pace_mins').val(pace_mins)

update_time = (dist, pm, ps) ->
	pt = pm*60 + ps
	time_secs = dist*pt
	time_mins = Math.round(time_secs/60)
	$('#run_time_text').val(time_mins)

update_dist = (tm, pm, ps) ->
	tt = tm*60
	pt = pm*60 + ps
	dist = Math.round(tt/pt)
	$('#run_distance').val(dist)

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
			else if dist and pace_mins and pace_secs
				update_time(dist, pace_mins, pace_secs)
		else if $(this).attr('name') == 'run[time_text]'
			if dist and time_mins
				update_pace(dist, time_mins)
			else if time_mins and pace_mins and pace_secs
				update_dist(time_mins, pace_mins, pace_secs)
		else
			if dist and pace_mins and pace_secs
				update_time(dist, pace_mins, pace_secs)
			else if time_mins and pace_mins and pace_secs
				update_dist(time_mins, pace_mins, pace_secs)
		


		# load_url = 'runs/' + run_id + '.json'
		# data = $('.runform_input').serializeArray()
		# $('#runModalLabel').text(data)
		# $.ajax(type: "PUT", dataType: "json", url: load_url, data: data, (JSON) ->
		# 	fill_in(JSON)
		# )



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