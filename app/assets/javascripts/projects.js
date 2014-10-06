// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function () {
  $('.nav-tabs a').on('click', function (e) {
    e.preventDefault();
    $(this).tab($(this).data('toggle'));
  });
});