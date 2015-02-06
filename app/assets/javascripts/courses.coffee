$ ->
  $('#send_invitation').on("ajax:success", (e, data, status, xhr) ->
    $('#send_invitation')[0].reset()
  ).on "ajax:error", (e, data, status, xhr) ->
    if data.responseJSON
      alert data.responseJSON.errors
    else
      alert "Błąd połączenia"
