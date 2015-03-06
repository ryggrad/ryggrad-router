# This class wraps an object or function that handles the route
# Allows us to add before/after filters to be called after or before the handler.
class RouteHandler
	constructor: (@path, @handler, @method=null) ->
		@beforeFilters = []
		@afterFilters  = []

	addBeforeFilter: (before) -> @beforeFilters.push before
	addAfterFilter:  (after)  -> @afterFilters.push after

	run: (params...) ->
		if @method
			for filter in @beforeFilters @handler[filter](params...)
			@handler[method](params...) 
			for filter in @afterFilters @handler[filter](params...)
		else
			@handler(params...)

module.exports = RouteHandler
