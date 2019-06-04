// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//

//= require rails-ujs
//= require jquery.validate
//= require jquery.validate.additional-methods

//= require turbolinks

//= require filterrific/filterrific-jquery

//--- Angle
//= require angle/modules/common/wrapper.js
//= require angle/app.init
//= require_tree ./angle/modules
//= require_tree ./angle/custom
//-- Selectize
//= require selectize

$(document).on('click', '.remove_fields', function (e) {
    //elimina el partial que tiene estos enlaces
    $(this).closest('fieldset').detach();
    e.preventDefault()
});

$(document).on('click', '.add_fields', function (e) {
    //console.log("add fields link clicked")
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    //console.log()
    $(this).before($(this).data('fields').replace(regexp, time))
    e.preventDefault()
});

