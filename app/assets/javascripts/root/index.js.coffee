$ ->
  $("a.burn-incense").on("ajax:success", (data, res, xhr) ->
    console.log("success#{res}")
    $("#incenses").html(res)
  )
