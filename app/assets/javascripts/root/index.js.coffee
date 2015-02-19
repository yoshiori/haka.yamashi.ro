$ ->
  $("a.burn-incense").on("ajax:success", (data, res, xhr) ->
    $("#incenses").html(res)
    $("#thankyou").modal()
  ).on("ajax:error", (xhr, status, error) ->
    if status.status == 409
      alert("一日一回までだよ")
  )
