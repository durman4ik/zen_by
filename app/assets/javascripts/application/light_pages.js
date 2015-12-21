//= require application/modernizr
//= require application/superfish.min
//= require application/btn-nav
//= require application/image-loader
//= require application/stick_menu
//= require application/forms
//= require application/validation
//= require_self


$(document).on('click', '.review_form_toggle_button', function(event) {
    event.preventDefault();

    $('.formbuilder#review_form').toggle(function(){
        $('.formbuilder#review_form').show('slide');
    }, function(){
        $('.review_form_toggle_button').toggle();
    });
});

