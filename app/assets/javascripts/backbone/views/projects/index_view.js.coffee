Todo.Views.Projects ||= {}

class Todo.Views.Projects.IndexView extends Backbone.View
  template: JST["backbone/templates/projects/index"]

  initialize: () ->
    @options.projects.bind('reset', @render)

  addAll: () =>
    @options.projects.each(@addOne)

  addOne: (project) =>
    view = new Todo.Views.Projects.ProjectView({model : project})
    @$("#projects-table").append(view.render().el)

  render: =>
    $(@el).html(@template(projects: @options.projects.toJSON() ))
    @addAll()

    return this
