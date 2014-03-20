function loadHardwares() {
  var hardwares = [];
  $.getJSON('/hardwares', function(data) {
    for(var i = 0; i < data.length; i++) {
      var obj = data[i];
      hardwares.push(obj['name']);
    }
    bindAutocomplete(hardwares);
  });
}

function bindAutocomplete(hardwares) {
  $('#hardware_name').on('keyup', function() {
    var text = $(this).val().toLowerCase();
    if(text.length > 1) {
      var available = [];
      for(var i = 0; i < hardwares.length; i++) {
        var hardwareName = hardwares[i];
        if(hardwareName.toLowerCase().indexOf(text) !== -1) {
          available.push(hardwareName);
        }
      }

      $('.hardwareList').remove();
      if(available.length > 0) {
        var div = $('<div class="hardwareList"></div>');
        var ul = $('<ul></ul>');
        for(var i = 0; i < available.length; i++) {
          var n = available[i];
          ul.append('<li>' + n + '</li>');
        }
        div.append(ul);
        $('#hardware_name').after(div.outerHTML());
        $('.hardwareList li').on('click', function() {
          $('#hardware_name').val($(this).text());
          $('.hardwareList').remove();
        });
      }
    }
  });
}