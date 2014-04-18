Todo.Views.Projects ||= {}

class Todo.Views.Projects.ProjectView extends Backbone.View
  template: JST["backbone/templates/projects/project"]

  initialize: ->
    @listenTo(@model, 'change', @render);
    @listenTo(@model, 'remove:tasks', @fix_order);

  events:
    "click .destroy" : "destroy"
    "click .update" : "update"
    "submit #frmNewTask" : "create"
    "dblclick #edit_proiect .view"  : "edit"
    "keypress #edit_proiect .edit"  : "updateOnEnter"
    "blur #edit_proiect .edit"      : "close"

  edit: ->
    @$('#edit_proiect').addClass("editing")
    @input.val(@model.get('title'))
    @input.select()
    @input.focus()

  close: ->
    if @$('#edit_proiect').hasClass("editing")
      @$('#edit_proiect').removeClass("editing"); 
      @model.save({title: @input.val()});
    
  updateOnEnter: (e) ->
    if (e.keyCode == 13)
      @input.blur()

  destroy: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @model.destroy()
    this.remove()

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @edit()  

  create: (e) ->
    e.preventDefault()
    e.stopPropagation()
    new_task = new Todo.Models.Task(
      project: @model
      priority: @model.get('tasks').length
      title: @$("#new_task_title").val()
      completed: false
    )
    if new_task.isValid()
      @addTask(new_task)
      @$("#new_task_title").val('')
      new_task.save()
    else
      new_task.destroy()
    
  fix_order: (rm_model, collection) ->
    i.set('priority', i.get('priority') - 1) for i in collection.models when i.get('priority') > rm_model.get('priority')

  addAllTasks: =>
    tasks = @model.get('tasks')
    tasks.each(@addTask)

  addTask: (task) =>
    view = new Todo.Views.Tasks.TaskView(model: task)
    @$("tbody").prepend(view.render().el)

  render: =>
    $(@el).html(@template(@model.toJSON() ))
    @addAllTasks()
    @input = @$('#project_title');
    return this
