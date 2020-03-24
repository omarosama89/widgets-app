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


//= require jquery
//= require jquery_ujs
//= require back/plugins/bootstrap/bootstrap.min
//= require back/plugins/bootstrap-tagsinput/bootstrap-tagsinput.min
//= require back/plugins/datatables/jquery.dataTables.min
//= require back/plugins/datatables/dataTables.bootstrap.min
//= require back/app
//= require_self


$(document).ready(function() {
    var table = $('.dataTable').DataTable();

    // Get sidebar state from localStorage and add the proper class to body
    $('body').addClass(localStorage.getItem('sidebar-state'));

    var activePage = stripTrailingSlash(window.location.pathname);
    $('.sidebar-menu li a').each(function(){
        var currentPage = stripTrailingSlash($(this).attr('href'));
        if (activePage == currentPage) {
            $(this).closest('.treeview').addClass('active');
            $(this).parent().addClass('active');
        }
    });
    function stripTrailingSlash(str) {
        if(str.substr(-1) == '/') { return str.substr(0, str.length - 1); }
        return str;
    }

    // Save sidebar state in localStorage browser
    $('.sidebar-toggle').on('click', function(){
        if($('body').attr('class').indexOf('sidebar-collapse') != -1) {
            localStorage.setItem('sidebar-state', '');
        } else {
            localStorage.setItem('sidebar-state', 'sidebar-collapse');
        }
    });
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

    $(".search-input").keyup(function(event) {
        if (event.keyCode === 13) {
            $(".search-button").click();
        }
    });
});


