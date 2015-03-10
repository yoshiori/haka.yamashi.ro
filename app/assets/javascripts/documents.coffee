# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("body").scrollspy({target: ".docs-sidebar"})
  $(document).on("ajax:success", "a.create-token", (data, res, xhr) ->
    $("#token").html(res)
    console.log(res)
  )
