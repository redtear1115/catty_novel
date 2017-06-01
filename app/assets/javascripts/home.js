$(this).keypress(keyPressHandler)

function keyPressHandler(event) {
  switch (event.which) {
    case 13: // enter: jump to
      break
    case 119: // w: collections
      if($('#top .collections').attr('href')) {
        window.location.replace($('#top .collections').attr('href'))
      }
      break
    case 115: // s: novels
      if($('#top .novels').attr('href')) {
        window.location.replace($('#top .novels').attr('href'))
      }
      break
    case 100: // d: next
      if($('#chp-nav #next_chp').attr('href')) {
        window.location.replace($('#chp-nav #next_chp').attr('href'))
      }
      break
    case 97: // a: prev
      if($('#chp-nav #prev_chp').attr('href')) {
        window.location.replace($('#chp-nav #prev_chp').attr('href'))
      }
      break
    default:break
  }
}
