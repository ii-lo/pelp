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
        link.html(unescape(link.data('flagged')))
      else
        link.html(unescape(link.data('not-flagged')))
    ).fail ->
      alert("Błąd połączenia")

  $('.lc_change_name').on 'click', (e)->
    e.preventDefault()
    $(this).parent().find('.edit_lc').toggleClass('hidden')
  $('.edit_lc').on("ajax:success", (e, data, status, xhr) ->
    $(this).addClass('hidden')
    data = data['lesson_category']
    $("[data-lc-id=#{data.id}]").text(data.name)
    $(this).find("#lesson_category_name").val(data.name)
  ).on("ajax:error", (e, data, status, xhr) ->
    if data.responseJSON
      alert data.responseJSON.errors[0]
    else
      alert "Błąd połączenia"
  )
