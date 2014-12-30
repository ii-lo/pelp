$ ->
  cclockData = 'cclock'
  cclockInternalData = 'cclock-internal'
  parseTimeStr = (str) ->
    arr = str.split ':'
    if(arr.length != 2)
      throw new Error 'invalid format'
    return {
      min: parseInt(arr[0]),
      sec: parseInt(arr[1])
    }
  mkTimeStr = (time) ->
    return time.min + ':' + (if time.sec < 10 then '0' + time.sec else time.sec + '')
  $.fn.cclock = (onExhausted) ->
    return this.each ->
      elem = $(this)
<<<<<<< HEAD
      elem.data cclockInternalData, $.extend(parseTimeStr(elem.text()), {
=======
      elem.data cclockInternalData, $.extend parseTimeStr(elem.text()), {
>>>>>>> eb1daec... Minor improvements
        exhausted: false,
        fn: onExhausted || (if elem.data(cclockData) then -> eval(elem.data(cclockData)) else $.noop),
        interv: setInterval ->
          data = elem.data(cclockInternalData)
          if !data.exhausted
            data.sec -= 1
            if data.sec < 0
              data.sec = 59
              data.min -= 1
              if data.min < 0
                data.min = data.sec = 0
                data.exhausted = true

                data.fn()

                clearInterval(data.interv)
                elem.removeData(cclockInternalData)
          elem.text(mkTimeStr(data))
        , 1000
<<<<<<< HEAD
      })
=======
      }
>>>>>>> eb1daec... Minor improvements
  $('[data-cclock]').cclock()

