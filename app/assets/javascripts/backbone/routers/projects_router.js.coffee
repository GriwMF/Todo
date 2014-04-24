class Todo.Routers.ProjectsRouter extends Backbone.Router
  initialize: (options) ->
    @projects = new Todo.Collections.ProjectsCollection()
    @projects.reset options.projects

  routes:
    "new"      : "newProject"
    "index"    : "index"
    ":id/edit" : "edit"
    "projects/:project_id/tasks/:id/edit" : "edit_task"
    ""        : "index"

  newProject: ->
    @view = new Todo.Views.Projects.NewView(collection: @projects)
    $("#projects-wrap").html(@view.render().el)

  index: ->
    @view = new Todo.Views.Projects.IndexView(collection: @projects)
    $("#projects-wrap").html(@view.render().el)

  show: (id) ->
    project = @projects.get(id)

    @view = new Todo.Views.Projects.ShowView(model: project)
    $("#projects-wrap").html(@view.render().el)

  edit: (id) ->
    project = @projects.get(id)

    @view = new Todo.Views.Projects.EditView(model: project)
    $("#projects-wrap").html(@view.render().el)

  edit_task: (project_id, id) ->
    project = @projects.get(project_id)
    task = project.get('tasks').get(id)
    @view = new Todo.Views.Tasks.EditView(model: task)
    $("#projects-wrap").html(@view.render().el)