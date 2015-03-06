RouteHandler = require 'ryggrad-router/RouteHandler'

class Handler
	cats: -> "Snow, Ballz"

describe "RouteHandler", ->
	it "should create a new RouteHandler instance", ->
		routeHandler = new RouteHandler()
		routeHandler.should.be.an.instanceOf RouteHandler

	it "should execute the handler", ->
		routeHandler = new RouteHandler('/users', new Handler(), 'cats')
		routeHandler.run().should.equal "Snow, Ballz"

	it "should allow us to add before filters", ->
		routeHandler = new RouteHandler('/users', new Handler(), 'cats')
		routeHandler.beforeFilters.length.should.equal 0
		routeHandler.addBeforeFilter -> #
		routeHandler.beforeFilters.length.should.equal 1

	it "should allow us to add after filters", ->
	  routeHandler = new RouteHandler('/users', new Handler(), 'cats')
		routeHandler.beforeFilters.length.should.equal 0
		routeHandler.addBeforeFilter -> #
		routeHandler.beforeFilters.length.should.equal 1

	it "should execute before filters", ->
		filterRan = false

		routeHandler = new RouteHandler('/users', new Handler(), 'cats')
		routeHandler.addBeforeFilter -> filterRan = true

		routeHandler.run()
		filterRan.should.be.true

	it "should execute after filters", ->
		filterRan = false

		routeHandler = new RouteHandler('/users', new Handler(), 'cats')
		routeHandler.addAfterFilter -> filterRan = true

		routeHandler.run()
		filterRan.should.be.true
