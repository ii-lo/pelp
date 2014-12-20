/// <reference path="../../../tsd/tsd.d.ts" />

//= require jquery
//= require jquery_ujs
//= require bootstrap

$(function () {
    var SHRINK_ON = 10;

    $(window).on('load scroll touchmove', function () {
        $('.shrinkable').toggleClass('tiny', $(document).scrollTop() > SHRINK_ON);
    });
});