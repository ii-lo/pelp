/// <reference path="tsd/tsd.d.ts" />

$('#refresh-btn').on('click', function(e) {
    e.preventDefault();
    var btn = $(this).button('loading');

    setTimeout(function() {
        btn.button('reset');
    }, 5000);
});

$('#send-msg-btn').on('click', function() {
    var btn = $(this).button('loading');

    setTimeout(function() {
        btn.button('reset');
        $('#compose-modal').modal('hide');
    }, 5000);
});
