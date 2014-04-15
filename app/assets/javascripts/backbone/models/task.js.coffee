class Todo.Models.Task extends Backbone.RelationalModel
  paramRoot: 'task'

  defaults:
    title: null
    
Todo.Models.Task.setup() 

class Todo.Collections.TasksCollection extends Backbone.Collection
  url: '/tasks'
