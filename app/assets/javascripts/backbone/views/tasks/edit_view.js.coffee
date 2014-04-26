Todo.Views.Tasks ||= {}

class Todo.Views.Tasks.EditView extends Backbone.View
  template : JST["backbone/templates/tasks/edit"]

  events :
    "submit #edit-task" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(title: @$('#title').val().trim(),
      success : (task) =>
        @model = task
        window.location.hash = "#/index"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    return this
