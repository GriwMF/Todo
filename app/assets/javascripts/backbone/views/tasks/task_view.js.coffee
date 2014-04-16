Todo.Views.Tasks ||= {}

class Todo.Views.Tasks.TaskView extends Backbone.View
  template: JST["backbone/templates/tasks/task"]

  tagName: 'tr'

  initialize: ->
    @listenTo(@model, 'change', @render);

  events:
    "click .destroy" : "destroy"
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
      @model.save({title: @input.val()});

  updateOnEnter: (e) ->
    if (e.keyCode == 13)
      @input.blur()

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  toggle_complete: ->
    completed = @model.get('completed')

    @model.save(completed: !completed)
    

  render: ->
    $(@el).html(@template(@model.toJSON()))
    @input = @$('#task_title');
    return this
