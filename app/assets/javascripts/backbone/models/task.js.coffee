class Todo.Models.Task extends Backbone.RelationalModel
  paramRoot: 'task'

  validate: (attrs) ->
    if (attrs.title == '')
      return "Task name can't be blank";
    
Todo.Models.Task.setup()

class Todo.Collections.TasksCollection extends Backbone.Collection
  model: Todo.Models.Task
  comparator: 'priority'
  url: ->
    return '/projects/' + @project.id + '/tasks'
