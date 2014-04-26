Todo.Views.Tasks ||= {}

class Todo.Views.Tasks.TaskView extends Backbone.View
  template: JST["backbone/templates/tasks/task"]

  tagName: 'tr'

  initialize: ->
    @listenTo(@model, 'change', @render);

  events:
    "click .destroy" : "destroy"
    "click .up" : "up"
    "click .down" : "down"
    "click .completed-checkbox" : "toggle_complete"
    "dblclick #edit_task"  : "edit"
    "keypress .edit"  : "updateOnEnter"
    "blur .edit"      : "close"

  edit: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @$('#edit_task').addClass("editing")
    @input.val(@model.get('title'))
    @input.select()

  close: (e) ->
    if @$('#edit_task').hasClass("editing")
      @$('#edit_task').removeClass("editing");  
      @model.save({title: @input.val().trim()});

  updateOnEnter: (e) ->
    if (e.keyCode == 13)
      @input.blur()

  destroy: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @model.destroy()
    this.remove()

  toggle_complete: ->
    completed = @model.get('completed')

    @model.save(completed: !completed)
  
  up: (e) ->
    e.preventDefault()
    e.stopPropagation()
    current_priority = @model.get('priority')
    if current_priority < @model.collection.length - 1
      switch_with = @model.collection.where(priority: current_priority + 1)[0]
      @model.set('priority', current_priority + 1)
      switch_with.set('priority', current_priority)
      @model.collection.sort()
      @model.get('project').trigger('change');
      @model.save()
      switch_with.save()

  down: (e) ->
    e.preventDefault()
    e.stopPropagation()
    current_priority = @model.get('priority')
    if current_priority > 0
      switch_with = @model.collection.where(priority: current_priority - 1)[0]
      @model.set('priority', current_priority - 1)
      switch_with.set('priority', current_priority)
      @model.collection.sort()
      @model.get('project').trigger('change');
      @model.save()
      switch_with.save()

  render: ->
    $(@el).html(@template(@model.toJSON()))
    @$el.attr('id', 'task' + @model.get('id'))
    @input = @$('#task_title');
    return this
