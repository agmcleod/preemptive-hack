$(document).ready(function() {
  console.log($('input[type=datetime]').length);
  $('input[type=datetime]').datepicker({
    format : 'yyyy-mm-dd'
  });
});
