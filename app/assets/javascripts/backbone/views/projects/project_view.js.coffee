Todo.Views.Projects ||= {}

class Todo.Views.Projects.ProjectView extends Backbone.View
  template: JST["backbone/templates/projects/project"]

  initialize: ->
    @listenTo(@model, 'change', @render);
    @listenTo(@model, 'remove:tasks', @fix_order);

  events:
    "click .destroy" : "destroy"
    "submit #frmNewTask" : "create_task"
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
      @model.save({title: @input.val().trim()});
    
  updateOnEnter: (e) ->
    if (e.keyCode == 13)
      @input.blur()

  destroy: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @model.destroy()
    this.remove()

  create_task: (e) ->
    e.preventDefault()
    e.stopPropagation()
    new_task = new Todo.Models.Task(
      project: @model
      priority: @model.get('tasks').length
      title: @$("#new_task_title").val().trim()
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
    @$('#table-tasks tbody').sortable(
      helper: (e, ui) ->
        ui.children().each ->
          $(this).width($(this).width());
        return ui
      update: (event, ui) =>
        task_id = ui.item.attr('id')
        task_id = /[^task]*$/.exec(task_id)[0]
        tasks = @model.get('tasks')
        task = tasks.get(task_id)
        priority = task.get('priority')
        current_priority = tasks.length - ui.item.index() - 1
        if current_priority > priority
          i.set('priority', i.get('priority')-1) for i in tasks.models when priority < i.get('priority') <= current_priority
        else
          i.set('priority', i.get('priority')+1) for i in tasks.models when current_priority <= i.get('priority') < priority
        data = task.toJSON()
        data.drag_n_drop = true
        data.priority = current_priority
        task.save(data)
        task.unset('drag_n_drop')
        tasks.sort()
        @render()
    )
    return this
