$ ->
  flashCallback = ->
    $(".alert").hide()
  $(".alert").bind 'click', (ev) =>
    $(".alert").hide()
  setTimeout flashCallback, 5000

$ ->
  flashCallback = ->
    $(".notice").hide()
  $(".notice").bind 'click', (ev) =>
    $(".notice").hide()
  setTimeout flashCallback, 5000