Todo.Views.Projects ||= {}

class Todo.Views.Projects.IndexView extends Backbone.View
  template: JST["backbone/templates/projects/index"]

  events:
    "submit #frmNewProj" : "create"

  initialize: () ->
    @collection.bind('reset', @render)

  create: (e) ->
    e.preventDefault()
    e.stopPropagation()
    title = @$("#new_proj_title").val()
    if title != ''
      @$("#new_proj_title").val('')
      @collection.create(title: title)
      @render()


  addAll: () =>
    @collection.each(@addOne)

  addOne: (project) =>
    view = new Todo.Views.Projects.ProjectView({model : project})
    @$("#projects-table").prepend(view.render().el)

  render: =>
    $(@el).html(@template(projects: @collection.toJSON() ))
    @addAll()

    return this
