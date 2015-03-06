Router       = require 'ryggrad-router'
RouteHandler = require 'ryggrad-router/RouteHandler'

class UsersHandler
  users: -> "Hey, ya!"

describe "Router", ->
  it "can set its path", ->
    router = new Router()
    router.getPath().should.be.falsey
    router.change()
    router.getPath().should.be.truthy

  it "can add a single route", ->
    router2 = new Router()
    router2.add "/foo"
    router2.routes.length.should.be 1

  it "can add a bunch of routes", ->
    router2 = new Router()
    router2.add
      "/foo": ->
      "/bar": ->

    router2.routes.length.should.be 2

  it "can add regex route", ->
    router2 = new Router()
    router2.add /\/users\/(\d+)/
    router2.routes.length.should.be 1

  it "should trigger 'change' when a route matches", ->
    changed = 0
    router.on "change", -> changed += 1
    
    router.add "/foo", ->
    router.navigate "/foo"
    
    changed.should.be 1

  it "can navigate to path", ->
    router.add "/users", ->

    navigate("/users")
    router.path.should.be "/users"

  it "can navigate to a path splitted into several arguments", ->
    router.add "/users/1/2", ->

    navigate("/users", 1, 2)
    router.getPath().should.be "/users/1/2"

  it "should execute a handler object", ->
  it "should recognize a route", ->
  it "should add before filters for a route", ->
  it "should add after filters for a route", ->
  it "should route", ->
  it "should execute before filters for a route", ->
  it "should execute after filters for a route", ->
