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
      else if $(this).text() == $(this).data('open')
        $(this).text($(this).data('closed'))

  class TimeHelper
    constructor: (@input, @minutes, @seconds) ->
      @prepare_time_input()

    prepare_time_input: ->
      $(@input).on 'change', =>
        # #js
        $(@minutes).val parseInt($(@input).val()) / 60 >> 0
        $(@seconds).val parseInt($(@input).val()) % 60
      $(@minutes).on 'change', =>
        $(@input).val @count()
      $(@seconds).on 'change', =>
        $(@input).val @count()

    count: ->
      parseInt($(@minutes).val()) * 60 + parseInt $(@seconds).val()

  new TimeHelper($('#exam_duration'), $('#minutes_helper'),
  $('#seconds_helper'))


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
    ).off("ajax:error").on "ajax:error", (e, xhr, status, error) ->
      alert "Coś poszło nie tak; prawodopodobnie nie masz uprawnień do tej akcji"

  destroy_links = ->
    for l_c in ['.destroy_answer', '.destroy_question']
      destroy_link(l_c)
    return

  destroy_links()

  prepare_toggle_links = ->
    toggle_link('.edit_qc_link', '.qc_edit_form')
    toggle_link('.edit_question_link', '.question_edit_form')
    toggle_link('.new_question_link', '.new_question_form')
    toggle_link('.edit_answer_link', '.answer_edit_form')

  prepare_toggle_links()

  edit_form = (form_class, to_edit, object_class, custom) ->
    $(form_class).off("ajax:success").on("ajax:success", (e, data, status, xhr) ->
      $(form_class).parent().addClass 'hidden'
      data = data[object_class]
      $(".#{to_edit}[data-id=#{data.id}]").text(data.name)
      custom(data) if custom
    ).off("ajax:error").on("ajax:error", (e, data, status, xhr) ->
      if data.responseJSON
        alert data.responseJSON.errors[0]
      else
        alert "Błąd połączenia"
    )

  prepare_edit_forms = ->
    edit_form('.edit_question_category', 'q_c', 'question_category')
    edit_form '.edit_question', 'question_body', 'question', (data) ->
      $(".question_value[data-id=#{data.id}]").text(data.value)
      $.get '/question_markdown/' + data.id, (response) ->
        $(".question_body[data-id=#{data.id}]").html(response)
    edit_form '.edit_answer', 'answer_name', 'answer', (data) ->
      correct = $(".answer[data-id=#{data.id}]").find('.correct_answer')
      if data.correct
        $(correct).text $(correct).data('correct')
      else
        $(correct).text $(correct).data('false')

  prepare_edit_forms()

  create_form = (form) ->
    $(form).off("ajax:success").on("ajax:success", (e, data, status, xhr) ->
      prepare_toggle_links()
      prepare_edit_forms()
      prepare_show_more()
      destroy_links()
      prepare_create_forms()
    ).off("ajax:error").on "ajax:error", (e, xhr, status, error) ->
      alert(xhr.responseJSON.errors[0])

  prepare_create_forms = ->
    create_form('.new_question')
    create_form('.new_answer')

  prepare_create_forms()
