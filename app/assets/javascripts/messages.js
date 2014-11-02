function preparePagination(str) {
    $('.' + str).on('click', function(e) {
        e.preventDefault();
        var re = /=([0-9]+)/;
        var found = e.target.href.match(re);
        $.post('messages/paginate', { page: found[1], type: str });
    });
}

function test() {
    $.each(['sent', 'received'], function(i, v) {
        preparePagination(v);
    });
}

$(document).ready(test);
$(document).on('page:load', test);

$(document).ready(function() {
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
});
