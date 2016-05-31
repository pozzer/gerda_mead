// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery2
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks

//= require bootstrap.min
//= require admin-lte


//= require_tree .
//= require_self


$(function () {

  // init geral do sistema
  Rendal.actual = {};
  Rendal.actual.controller = $('body').attr('data-controller');
  Rendal.actual.action = $('body').attr('data-action');
  try {
    Rendal[Rendal.actual.controller][Rendal.actual.action]['init'].call();
  } catch(e) {
    debug(e);
    debug("\"Rendal." + Rendal.actual.controller + "." + Rendal.actual.action + ".init()\" não existe.");
  }

})
