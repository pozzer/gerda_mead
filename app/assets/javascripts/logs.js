if (window.Rendal === undefined) window.Rendal = {};
if (window.Rendal.logs == undefined) window.Rendal.logs = {};

window.Rendal.logs.index = function() {

  var pub = {};

  pub.init = function(){
    window.Rendal.per_page_btn_group.init();
  }

  return pub;
}();
