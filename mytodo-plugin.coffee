# MyTodo Plugins
timeout = 10 * 1000
interval = 100
modules = ['jquery'
	, '//dl.dropboxusercontent.com/u/92165755/js/shortcut.js'
	, '//dl.dropboxusercontent.com/u/92165755/js/util.js']
	
# load require.js	
waitRequirejsLoaded = (callback) ->
	perform = ->
		timeout -= interval
		if (typeof require isnt 'undefined')
			console.log 'perform'
			require.config
				baseUrl: '//dl.dropboxusercontent.com/u/92165755/js'
				paths: jquery:
					'jquery.min'
			callback()
		else if (timeout > 0)
			waitRequirejsLoaded()
		else
			console.log('abort')
	
	setTimeout(perform, interval)

loadCSS = (href) ->
	document.write('<link rel="stylesheet" type="text/css" href="' + href + '" />');

setDetailPageAction = ->
	require modules, ($) ->
		$mydate = $('div#record-gaia').find('div.input-date-cybozu input')
		getNowTime = () -> dateFormat(new Date, '%h:%m') + " " + (if new Date().getHours() > 12 then "PM" else "AM")

		# define shortcut-keys
		shortcut.add "Ctrl+Alt+D", () -> $(':focus').val dateFormat(new Date, '%y-%M-%d')
		shortcut.add "Ctrl+Alt+T", () -> $(':focus').val getNowTime()

		# set default-focus
		console.log 'detail page'
		setTimeout () ->
			$mydate.focus();
		, 200

listPage = ->
	require modules, ($) ->
		# add icon
		console.log 'list page'
		el = kintone.app.getHeaderMenuSpaceElement();
		$icon = $('<img>').attr('src','//dl.dropboxusercontent.com/u/92165755/img/button-plus.png')
		$icon.css
			width: '20px'
			height: '20px'
			position: 'relative'
			top: '5px'
			cursor: 'pointer'
		$(el).append $icon

		# new button click event
		$icon.on "click", () ->
			console.log "new button clicked"
			# display contents
			condition = kintone.app.getQueryCondition();
			console.log condition
			kintone.api '/k/v1/records', 'GET',
				app: kintone.app.getId()
				query: condition
			, (res) ->
				console.log res
				report = {}
				text = ""
				for task in res.records
					console.log task
					report[task['project'].value] = [] unless task['project'].value of report
					report[task['project'].value].push task['task'].value
				console.log report
				for k,v of report
					text = "#{text}\r\n[#{k}]\r\n"
					for work in v
						text = "#{text}・#{work}\r\n"
				alert text
	
# kintone event settings
kintone.events.on 'app.record.edit.show', (event) ->
	console.log "edit page"	
	waitRequirejsLoaded(setDetailPageAction)

kintone.events.on 'app.record.index.show', (event) ->
	console.log "index page"	
	waitRequirejsLoaded(listPage)

# bootstrap	
# loadCSS('//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css')	


