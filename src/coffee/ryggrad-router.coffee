{isString}      = require 'underscore'
RouteRecongizer = require 'route-recognizer'
RouteHandler    = require 'ryggrad-router/RouteHandler'

class Router
	constructor: ->
		@path   = ''
    @nameRoutes = {}
    @routes     = []
    $(window).on('popstate', @change)
		@recognizer = new RouteRecongizer()

	add: (path, handler) ->
		if _.isString handler
			throw new Error("Handler string should have a method") unless handler.indexOf("#") != -1
			handler       = handler.split "#"
			handerlerName = handler[0]
      method        = handler[1]

		  if @handlers.hasOwnProperty handlerName
		   handler = new window[handerlerName]
			 @handlers[handlerName] = handler
			else
				@handler = @handlers

			route = {name: method, path: path, handler: new RouteHandler(path, handler, method)}

			@namedRutes[method] = route
			@routes.push route
			@recognizer.push route

			@addBeforeFilters(handler.beforeFilters, method) if handler.beforeFilters?
			@addAfterFiters(handler.afterFilters, method)    if handler.afterFilters?
		else
			route = {name: path, path: path, handler: new RouteHandler(path, handler)}
			@nameRoutes[path] = route
			@routes.push route
			@recognizer.push route

	addBeforeFilters: (befores, route) ->
		if _.isArray befores
			for before in befores
				@namedRoutes[route].handler.addBeforeFilter before.func
		else
			for route in @routes
				route.handler.addBeforeFilter(befores)

	addAfterFilters: (afters, route) ->
		if _.isArray afters
			for after in afters
				@namedRoutes[route].handler.addAfterFilter after.func
		else
			for route in @routes
				route.handler.addAfterFilter(afters)

	route: (path) ->
		route = @recognizer.recognize(path)
		route[0].handler.run(route.params)

  navigate: (@path, title=document.title) =>
    return if @locationPath() is @path
    history?.pushState?({}, title, @path)

  getPath: => @path

  locationPath: =>
    path = window.location.pathname
    path = '/' + path if path.substr(0,1) isnt '/'
    path

  change: =>
    path = @locationPath()
    return if path is @path
    @path = path
    @route(@path)

module.exports = Router
