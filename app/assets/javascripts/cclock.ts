/// <reference path="../../../tsd/tsd.d.ts" />

interface CClockTime {
    min:number;
    sec:number;
}

interface JQuery {
    cclock:(onExhausted?:()=>void)=>JQuery;
}

(function ($:JQueryStatic) {
    var cclockData = 'cclock',
        cclockInternalData = 'cclock-internal';

    function parseTimeStr(str:string):CClockTime {
        var arr = str.split(':');
        if (arr.length != 2) throw new Error('invalid format');
        return {
            min: parseInt(arr[0]),
            sec: parseInt(arr[1])
        }
    }

    function mkTimeStr(time:CClockTime):string {
        return time.min + ':' + (time.sec < 10 ? '0' + time.sec : time.sec + '');
    }

    $.fn.cclock = function (onExhausted?:()=>void):JQuery {
        return this.each(function () {
            var elem = $(this);

            elem.data(cclockInternalData, $.extend(parseTimeStr(elem.text()), {
                exhausted: false,
                fn: onExhausted || (elem.data(cclockData) ? () => eval(elem.data(cclockData)) : $.noop), // Need to test this somehow ^.^
                interv: setInterval(function () {
                    var data = elem.data(cclockInternalData);

                    // TODO This nasty if should be rewritten.
                    if (!data.exhausted) {
                        data.sec--;

                        if (data.sec < 0) {
                            data.sec = 59;
                            data.min--;

                            if (data.min < 0) {
                                data.min = data.sec = 0;
                                data.exhausted = true;

                                data.fn();

                                clearInterval(data.interv);
                                elem.removeData(cclockInternalData);
                            }
                        }
                    }

                    elem.text(mkTimeStr(data));
                }, 1000)
            }));
        });
    };

    $(function () {
        $('[data-cclock]').cclock();
    });
})(jQuery);
