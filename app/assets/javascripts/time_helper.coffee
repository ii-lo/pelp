class @TimeHelper
  constructor: (@input, @minutes, @seconds) ->
    @prepare_time_input()

  prepare_time_input: ->
    @input.on 'change', =>
      # #js
      @minutes.val parseInt(@input.val()) / 60 >> 0
      @seconds.val parseInt(@input.val()) % 60
    @minutes.on 'change', =>
      @input.val @count()
    @seconds.on 'change', =>
      @input.val @count()

  count: ->
    parseInt(@minutes.val()) * 60 + parseInt @seconds.val()
