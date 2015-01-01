//= require marked
//= require bootstrap-markdown
//= require bootstrap-markdown.pl.js


$ ->
  $(".show_more > a").on 'click', (e) ->
    e.preventDefault()
    $(this).parent().parent()
      .find('.' + $(this).data('expand')).toggleClass('hidden')
    if $(this).text() == $(this).data('closed')
      $(this).text($(this).data('open'))
    else
      $(this).text($(this).data('closed'))

  $('.hide_all > a').on 'click', (e) ->
    e.preventDefault()
    $('.to_expand').addClass('hidden')
    $('.show_more > a').each ->
      $(this).text($(this).data('closed'))

  $('.edit_qc_link').on 'click', (e) ->
    e.preventDefault()
    $(this).parent().find('.qc_edit_form').toggleClass('hidden')

  $('.edit_question_category').submit (e) ->
    params = $(this).serializeArray()
    form = $(this)
    $.ajax $(this).attr('action'),
      type: 'PUT',
      dataType: 'json',
      data: params,
      success: (data) ->
        $(form).parent().addClass 'hidden'
        data = data.question_category
        $('.q_c[data-id=' + data.id + ']').text(data.name)
      ,
      error: (data) ->
        errors = $.parseJSON(data.responseText).errors
        alert(errors)
    e.preventDefault()
    false
