class Todo.Models.Task extends Backbone.RelationalModel
  paramRoot: 'task'

  defaults:
    title: null

  initialize: ->
    @on("invalid", (model,error) ->
      alert(error);
    )

  validate: (attrs,options) ->
    if (attrs.title == '')
      return "Task name can't be blank";
    
Todo.Models.Task.setup()

class Todo.Collections.TasksCollection extends Backbone.Collection
  model: Todo.Models.Task
  url: ->
    return '/projects/' + @project.id + '/tasks'
