class Todo.Routers.ProjectsRouter extends Backbone.Router
  initialize: (options) ->
    @projects = new Todo.Collections.ProjectsCollection()
    @projects.reset options.projects

  routes:
    "new"      : "newProject"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newProject: ->
    @view = new Todo.Views.Projects.NewView(collection: @projects)
    $("#projects").html(@view.render().el)

  index: ->
    @view = new Todo.Views.Projects.IndexView(projects: @projects)
    $("#projects").html(@view.render().el)

  show: (id) ->
    project = @projects.get(id)

    @view = new Todo.Views.Projects.ShowView(model: project)
    $("#projects").html(@view.render().el)

  edit: (id) ->
    project = @projects.get(id)

    @view = new Todo.Views.Projects.EditView(model: project)
    $("#projects").html(@view.render().el)
