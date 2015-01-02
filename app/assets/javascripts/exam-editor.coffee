//= require marked
//= require bootstrap-markdown
//= require bootstrap-markdown.pl.js


$ ->
  prepare_show_more = ->
    $(".show_more > a").off('click').on 'click', (e) ->
      e.preventDefault()
      $(this).parent().parent()
        .find('.' + $(this).data('expand')).toggleClass('hidden')
      if $(this).text() == $(this).data('closed')
        $(this).text($(this).data('open'))
      else
        $(this).text($(this).data('closed'))

  prepare_show_more()

  $('.hide_all > a').on 'click', (e) ->
    e.preventDefault()
    $('.to_expand').addClass('hidden')
    $('.show_more > a').each ->
      $(this).text($(this).data('closed'))

  toggle_link = (link, to_toggle) ->
    $(link).off('click').on 'click', (e) ->
      e.preventDefault()
      $(this).parent().find(to_toggle).toggleClass('hidden')

  destroy_link = (link) ->
    $(link).off('ajax:success').on('ajax:success', (e, data, status, xhr) ->
      $(this).parent().parent().remove()
    ).on "ajax:error", (e, xhr, status, error) ->
      alert "Coś poszło nie tak; prawodopodobnie nie masz uprawnień do tej akcji"

  destroy_links = ->
    for l_c in ['.destroy_answer', '.destroy-question']
      destroy_link(l_c)
    return

  destroy_links()

  prepare_links = ->
    toggle_link('.edit_qc_link', '.qc_edit_form')
    toggle_link('.edit_question_link', '.question_edit_form')
    toggle_link('.new_question_link', '.new_question_form')
  prepare_links()

  edit_form = (form_class, to_edit, object_class, custom) ->
    $(form_class).off("ajax:success").on("ajax:success", (e, data, status, xhr) ->
      $(form_class).parent().addClass 'hidden'
      data = data[object_class]
      $('.' + to_edit + '[data-id=' + data.id + ']').text(data.name)
      custom(to_edit, data) if custom
    ).off("ajax:error").on("ajax:error", (e, data, status, xhr) ->
      alert data.responseJSON.errors[0]
    )

  prepare_forms = ->
    edit_form('.edit_question_category', 'q_c', 'question_category')
    edit_form '.edit_question', 'question', 'question', (to_edit, data) ->
      $.get '/question_markdown/' + data.id, (response) ->
        $('.' + to_edit + '[data-id=' + data.id + ']').html(response)
  prepare_forms()

  $(".new_question").on("ajax:success", (e, data, status, xhr) ->
    prepare_links()
    prepare_forms()
    prepare_show_more()
    destroy_links()
  ).on "ajax:error", (e, xhr, status, error) ->
    alert(xhr.responseJSON.errors[0])


