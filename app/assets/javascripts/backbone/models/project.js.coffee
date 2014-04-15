class Todo.Models.Project extends Backbone.RelationalModel
  paramRoot: 'project'

  defaults:
    title: null

  relations: [
    type: Backbone.HasMany
    key: 'tasks'
    relatedModel: 'Todo.Models.Task'
    collectionType: 'Todo.Collections.TasksCollection'
    includeInJSON: false
    reverseRelation:
      key: 'project_id',
      includeInJSON: 'id'
  ]

Todo.Models.Project.setup()

class Todo.Collections.ProjectsCollection extends Backbone.Collection
  model: Todo.Models.Project
  url: '/projects'
