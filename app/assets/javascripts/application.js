// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery

//= require bootstrap
//= require turbolinks
//= require app
//= require jquery_ujs
//= require_tree .

$('#email-field').focusout(function(){
    $.get('/api/users/check_email', {user: {email: $('#email-field').val()}}, function(data, status){
        $('#check-email-status').empty();
        if(data.data.available){
            $('#check-email-status').append('<div class="alert alert-success">Email is available</div>');
            $('#signup-button').removeAttr('disabled')
        }
        else{
            $('#check-email-status').append('<div class="alert alert-danger">Email is not available</div>');
            $('#signup-button').attr('disabled', 'disabled')
        }
    })
});

$('#reset-password-email-field').focusout(function(){
    $.get('/api/users/check_email', {user: {email: $('#reset-password-email-field').val()}}, function(data, status){
        $('#reset-password-email-status').empty();
        if(data.data.available){
            $('#reset-password-email-status').append('<div class="alert alert-danger">Email is not valid</div>');
            $('#reset-password-button').attr('disabled', 'disabled')
        }
        else{
            $('#reset-password-email-status').append('<div class="alert alert-success">Email is valid</div>');
            $('#reset-password-button').removeAttr('disabled')
        }
    })
});