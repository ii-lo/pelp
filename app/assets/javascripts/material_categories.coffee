# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#delete_material_category').on 'click', (e) ->
    this.blur();
    console.log 'h'
    if !confirm("Usuwając usuwasz też wszystkie materiały w grupie")
        e.preventDefault();
