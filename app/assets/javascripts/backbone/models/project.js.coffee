class Todo.Models.Project extends Backbone.RelationalModel
  paramRoot: 'project'

  defaults:
    title: null

  initialize: ->
    @on("invalid", (model,error) ->
      alert(error);
    )

  validate: (attrs,options) ->
    if (attrs.title == '')
      return "Project name can't be blank";

  relations: [
    type: Backbone.HasMany
    key: 'tasks'
    relatedModel: 'Todo.Models.Task'
    collectionType: 'Todo.Collections.TasksCollection'
    includeInJSON: false
    reverseRelation:
      key: 'project'
      includeInJSON: false
  ]

Todo.Models.Project.setup()

class Todo.Collections.ProjectsCollection extends Backbone.Collection
  model: Todo.Models.Project
  url: '/projects'
