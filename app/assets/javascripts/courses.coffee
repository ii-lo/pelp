$ ->
  $('#send_invitation').on("ajax:success", (e, data, status, xhr) ->
    $('#send_invitation')[0].reset()
  ).on "ajax:error", (e, data, status, xhr) ->
    if data.responseJSON
      alert data.responseJSON.errors
    else
      alert "Błąd połączenia"
  $('.flag_link > a').on 'click', (e) ->
    e.preventDefault()
    link = $(this)
    $.ajax({
      url: "#{link.attr('href')}.json",
      type: 'GET',
      dataType: 'json'
    }).done((data) ->
      link.parent().parent().parent()
        .toggleClass('panel-primary').toggleClass('panel-default')
      link.parent().toggleClass 'flagged'
      if data.flagged
        link.text(link.data('flagged'))
      else
        link.text(link.data('not-flagged'))
    ).fail ->
      alert("Błąd połączenia")
