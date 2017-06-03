$(this).keypress(keyPressHandler)

function keyPressHandler(event) {
  var target_path = null
  switch (event.which) {
    case 119: // w: collections
      target_path = $('#top .collections').attr('href')
      break
    case 115: // s: novels
      target_path = $('#top .novels').attr('href')
      break
    case 100: // d: next chapter
      target_path = $('#chp-nav #next_chp').attr('href')
      break
    case 97: // a: prev chapter
      target_path = $('#chp-nav #prev_chp').attr('href')
      break
    default:break
  }

  if(target_path) {
    window.location.replace(target_path)
  }
}
