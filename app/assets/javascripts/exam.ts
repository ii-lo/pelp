/// <reference path="../../../tsd/tsd.d.ts" />

//= require cclock

$(function () {
    $('[href="/exam/exit"]').on('click', function (e:JQueryEventObject) {
        if (!confirm("Czy na pewno chcesz zakończyć egzamin?")) {
            e.preventDefault();
        }
    });
});