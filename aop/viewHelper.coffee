
module.exports = (app)->

	# Wrap html as functions
	app.locals.macro = (src, args...)->
		return src if typeof src isnt "function"
		arr = []
		params = [arr].concat args
		src.apply(null, params)

		return arr.join("")

	# Check variable exists
	# <%=_r(abc) %>
	app.locals._r = (src)->
		return if typeof src is "undefined" then "" else src

	# didn't work
	app.locals.shunp = (data)->
		buf = []
		__stack = {}
		txt = data.replace("\n", "")
		try
			eval(txt);
			# (new Function("" + data.replace("\n", ""))).bind({ buf: buf })
		catch e
			console.log "Error when shunp:", e

		return buf.join("")
