//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require bootstrap

$(function () {
    var SHRINK_ON = 10;

    $(window).on('load scroll touchmove', function () {
        $('.shrinkable').toggleClass('tiny', $(document).scrollTop() > SHRINK_ON);
    });
});
