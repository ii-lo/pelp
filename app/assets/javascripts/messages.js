// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var prepare_pagination = function(str)
{
  $('.' + str).on('click', function(e)
  {
    e.preventDefault();
    var re = /=([0-9]+)/;
    var found = e.target.href.match(re);
    $.post("messages/paginate",
      { page: found[1], type: str }
    )
  })
}
var test = function()
{
  $.each(['sent', 'received'], function(ind, a) {
    prepare_pagination(a);
  });
}
$(document).ready(test);
$(document).on('page:load', test);
