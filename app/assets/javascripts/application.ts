/// <reference path="../../../tsd/tsd.d.ts" />

//= require jquery
//= require jquery_ujs
//= require bootstrap

// Counter clocks

class CounterClockTime {
    minutes:number = 0;
    seconds:number = 0;
    exhausted:boolean = false;
    onExhausted:()=>void;

    constructor(str:string, onExhausted?:()=>void) {
        var arr = str.split(':');
        if (arr.length != 2) throw new Error('invalid format');
        this.minutes = parseInt(arr[0]);
        this.seconds = parseInt(arr[1]);
        this.onExhausted = onExhausted;
    }

    tick() {
        if (!this.exhausted) {
            this.seconds--;
            if (this.seconds < 0) {
                this.seconds = 59;
                this.minutes--;
                if (this.minutes < 0) {
                    this.minutes = 0;
                    this.seconds = 0;
                    this.exhausted = true;
                    if (this.onExhausted) {
                        this.onExhausted();
                    }
                }
            }
        }
    }

    toString():string {
        return this.minutes + ':' + (this.seconds < 10 ? '0' + this.seconds : this.seconds + '');
    }
}

class CounterClock {
    obj:any;
    time:CounterClockTime;
    interv:number;

    constructor(obj:any) {
        this.obj = obj;
        this.time = new CounterClockTime(obj.text(), () => {
            if (this.obj.data('counter-clock-on-exhausted')) {
                eval(this.obj.data('counter-clock-on-exhausted'));
            }
            clearInterval(this.interv);
        });
        this.interv = setInterval(() => {
            this.time.tick();
            this.obj.text(this.time.toString());
        }, 1000);
    }
}

$(function () {
    $('.counter-clock').each(function () {
        new CounterClock($(this));
    });
});