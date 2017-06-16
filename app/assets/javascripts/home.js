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
    var objUrlParams = getUrlParameter(target_path)
    if(objUrlParams.novel_id && objUrlParams.chp_idx) {
      pageChangeHandler(objUrlParams.novel_id, objUrlParams.chp_idx)
    } else {
      window.location.replace(target_path)
    }
  }
}

function pageChangeHandler(novel_id, chp_idx) {
  const setup_chp_idx_api = 'api/v1/setup_chp_idx'
  const read_api = 'read'
  var sQuery = '?chp_idx='+chp_idx+'&novel_id='+novel_id
  $.get(setup_chp_idx_api+sQuery)
  window.location.replace(read_api+sQuery)
}

function getUrlParameter(url) {
  var sUrlParams = decodeURIComponent(url.split('?')[1])
  var aUrlParams = sUrlParams.split('&')
  var objUrlParams = {}

  aUrlParams.forEach(function (sUrlParam) {
    aUrlColumn = sUrlParam.split('=')
    objUrlParams[aUrlColumn[0]] = aUrlColumn[1]
  })
  return objUrlParams
}
