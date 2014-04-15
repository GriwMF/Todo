Todo.Views.Projects ||= {}

class Todo.Views.Projects.ProjectView extends Backbone.View
  template: JST["backbone/templates/projects/project"]

  events:
    "click .destroy" : "destroy"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  addAllTasks: =>
    console.log(@model)
    tasks = @model.get('tasks')

    console.log(tasks.at(0))
    tasks.each(@addTask)

  addTask: (task) =>
    view = new Todo.Views.Tasks.TaskView(model: task)
    @$("tbody").append(view.render().el)

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    @addAllTasks()
    return this
