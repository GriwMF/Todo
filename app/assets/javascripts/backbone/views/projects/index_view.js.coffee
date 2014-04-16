Todo.Views.Projects ||= {}

class Todo.Views.Projects.IndexView extends Backbone.View
  template: JST["backbone/templates/projects/index"]

  initialize: () ->
    @collection.bind('reset', @render)

  addAll: () =>
    @collection.each(@addOne)

  addOne: (project) =>
    view = new Todo.Views.Projects.ProjectView({model : project})
    @$("#projects-table").append(view.render().el)

  render: =>
    $(@el).html(@template(projects: @collection.toJSON() ))
    @addAll()

    return this
