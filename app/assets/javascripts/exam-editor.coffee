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
