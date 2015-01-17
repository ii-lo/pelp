#= require cclock
$ ->
  $('[data-toggle="tooltip"]').tooltip({ delay: { show: 600 } })
  $('[href="/exam/exit"]').on 'click', (e) ->
    this.blur();
    if !confirm("Czy na pewno chcesz zakończyć egzamin?")
        e.preventDefault();
