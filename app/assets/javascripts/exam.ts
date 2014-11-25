/// <reference path="../../../tsd/tsd.d.ts" />

$(function () {
    $('#end-exam-btn').on('click', function (e:JQueryEventObject) {
        if (!confirm("Czy na pewno chcesz zakończyć egzamin?")) {
            e.preventDefault();
        }
    });
});