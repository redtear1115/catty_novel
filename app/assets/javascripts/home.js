$(this).keypress(keyPressHandler)
$(window).scroll(scrollHandler)

function keyPressHandler(event) {
  var target_path = null
  switch (event.which) {
    case 13: // enter: jump to
      break
    case 119: // w: collections
      target_path = $('#top .collections').attr('href')
      break
    case 115: // s: novels
      target_path = $('#top .novels').attr('href')
      break
    case 100: // d: next
      target_path = $('#chp-nav #next_chp').attr('href')
      break
    case 97: // a: prev
      target_path = $('#chp-nav #prev_chp').attr('href')
      break
    default:break
  }

  if(target_path) {
    window.location.replace(target_path)
  }
}

function scrollHandler(e) {
  var target_path = null

  if($(window).scrollTop() + $(window).height() == $(document).height()) {
    target_path = $('#chp-nav #next_chp').attr('href')
  }

  if(target_path) {
    wait(3000);
    window.location.replace(target_path)
  }
}

function wait(ms){
   var start = new Date().getTime();
   var end = start;
   while(end < start + ms) {
     end = new Date().getTime();
  }
}
