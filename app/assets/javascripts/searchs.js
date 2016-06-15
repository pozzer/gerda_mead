if (window.Rendal === undefined) window.Rendal = {};
if (window.Rendal.searchs == undefined) window.Rendal.searchs = {};

window.Rendal.searchs.index = function() {

  var pub = {};

  pub.init = function(){
		$("#base-material-text").keyup(function(){
		  $.ajax({
			  url: "/searchs",
			  data: {valor: $(this).val()},
			}).done(function(data) {
			  console.log(data);
			});
  	});
	}
  return pub;
}();
