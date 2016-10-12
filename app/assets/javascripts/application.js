//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require tether
//= require bootstrap
//= require turbolinks
//= require nprogress
//= require nprogress-turbolinks
//= require_tree .

NProgress.configure({
  showSpinner: false,
  ease: 'ease',
  speed: 500
});

var ready = function() {
  $('[data-toggle="tooltip"]').tooltip();
};
$(document).on('turbolinks:load', ready);
