Todo.Views.Projects ||= {}

class Todo.Views.Projects.EditView extends Backbone.View
  template : JST["backbone/templates/projects/edit"]

  events :
    "submit #edit-project" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(title: @$('#title').val().trim(),
      success : (project) =>
        @model = project
        window.location.hash = "#/index"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    return this
