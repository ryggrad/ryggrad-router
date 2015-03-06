we want our controllers to be instances
we want them to support before after callbacks

before and after mtehods can jsut take the method
then we just need route-recognizer type of object

so the app class instantiates a router and when the path is matched (or navigate is called)
the controller is called.
actually what is called is the route which holds the controller instance.
and some after/before callbacks.
the router itself is responsible for constructing the objects and constructing the routes

controller calls before and this hits app.router

so wehn before gets called it can just wait until .router is set
then it pulls all the befores.
and it has to figure out how to add them.

## TODOS

Resolve the handler naming conventions ambiguities
