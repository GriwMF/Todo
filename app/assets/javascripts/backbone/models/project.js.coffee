class Todo.Models.Project extends Backbone.Model
  paramRoot: 'project'

  defaults:
    title: null

class Todo.Collections.ProjectsCollection extends Backbone.Collection
  model: Todo.Models.Project
  url: '/projects'
