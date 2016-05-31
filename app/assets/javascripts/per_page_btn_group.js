if (window.Rendal === undefined) window.Rendal = {};

window.Rendal.per_page_btn_group = function() {
  var pub = {};

  pub.init = function(options) {
    $('input:radio[name^="per_page"]').change(function(){
      $('form').submit();
    });
  }

  return pub;
}();
