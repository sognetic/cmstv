$.urlParam = function(name){
  var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
  if (results==null){
    return null;
  }
  else{
    return results[1] || 0;
  }
}

$(document).ready(function() {
  setInterval("document.getElementById ('date-time').firstChild.data = new Date().toLocaleString()", 50);
  $('.slideshow').cycle({
    slideResize: true,
    containerResize: true,
    fit: 1,
    fx: ($.urlParam('fx')) ? $.urlParam('fx') : 'scrollLeft',
    speed: ($.urlParam('speed')) ? $.urlParam('speed') : 100,
    timeout: ($.urlParam('timeout')) ? $.urlParam('timeout') : 30000 ,
    before: onBefore
  });
});
function onBefore(curr, next, opt) {
  //currSlideElement.reload(true);
  $('img', curr).each(function () {
    var jqt = $(this);
    var src = jqt.attr('src');
    var par = '?_=';
    if(src.indexOf('?') > -1)
    {
      par = '&_ts=';
    }
    src = src.substr(0,(src.indexOf(par) > 0) ? src.indexOf(par) : src.length);
    src += par + new Date().getTime();
    jqt.attr('src',src);
  });
};

