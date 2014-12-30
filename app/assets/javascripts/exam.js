/// <reference path="../../../tsd/tsd.d.ts" />

//= require cclock

$(function () {
    $('[data-toggle="tooltip"]').tooltip({delay: {show: 600}});

    $('[href="/exam/exit"]').on('click', function (e) {
        this.blur();

        if (!confirm("Czy na pewno chcesz zakończyć egzamin?")) {
            e.preventDefault();
        }
    });
});
