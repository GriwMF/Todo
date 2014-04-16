Todo.Views.Projects ||= {}

class Todo.Views.Projects.ProjectView extends Backbone.View
  template: JST["backbone/templates/projects/project"]

  initialize: ->
    @listenTo(@model, 'change', @render);

  events:
    "click .destroy" : "destroy"
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

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  create: (e) ->
    e.preventDefault()
    e.stopPropagation()
    new_task = new Todo.Models.Task(
      project: @model
      title: @$("#new_task_title").val()
      completed: false
    )

    new_task.save(null,
      success: =>
        @addTask(new_task)
        @$("#new_task_title").val('')
    )
    

  addAllTasks: =>
    tasks = @model.get('tasks')
    tasks.each(@addTask)

  addTask: (task) =>
    view = new Todo.Views.Tasks.TaskView(model: task)
    @$("tbody").append(view.render().el)

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    @addAllTasks()
    @input = @$('#project_title');
    return this
