loadCSS = (href) ->
	document.write('<link rel="stylesheet" type="text/css" href="' + href + '" />');

kintone.events.on 'mobile.app.record.index.show', (event) ->
	console.log "index page"	
	el = kintone.mobile.app.getHeaderSpaceElement();
	console.log el

	$dig = $('<div>').attr
		'id': 'dialog'
		'title': 'スペシャルインプット画面'

	contents = """
<div class='viewport'>
    <div class='flipsnap'>
        <div class='item'>1</div>
        <div class='item'>2</div>
        <div class='item'>3</div>
    </div>
</div>
	"""
		
	$(contents).appendTo $dig
	console.log $dig
	$dig.appendTo "body"

	$icon = $('<img>').attr('src','//dl.dropboxusercontent.com/u/92165755/img/button-doc.png')
	$icon.css
		width: '20px'
		height: '20px'
		position: 'relative'
		top: '5px'
		left: '15px'
		cursor: 'pointer'
	$(el).append $icon

	$icon.on "click", () ->
		console.log "new button clicked"
		$("#dialog").dialog()
		sleep 500
		Flipsnap('.flipsnap')
		console.log "complete!"

# loadCSS('//code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.css')
loadCSS('//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css')
loadCSS('//dl.dropboxusercontent.com/u/92165755/css/flip.css')

