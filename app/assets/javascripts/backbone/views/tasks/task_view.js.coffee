Todo.Views.Tasks ||= {}

class Todo.Views.Tasks.TaskView extends Backbone.View
  template: JST["backbone/templates/Tasks/task"]

  tagName: 'tr'

  events:
    "click .destroy" : "destroy"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model))
    return this
