//= require jquery

$(document).ready(function () {
    $('#widgets-search-btn').click(function () {
        $('#search-icon').addClass('fa-spin');
        $.get('/api/widgets', {term: $('#widgets-search-field').val()}, function (data, status) {
            $('#widgets-table-body').empty()
            $('#search-icon').removeClass('fa-spin');
            data.forEach(function(widget){
                $('#widgets-table-body').append(`<tr><td scope="row">${widget.name}</td><td scope="row">${widget.description}</td><td scope="row">${widget.kind}</td><td scope="row"><a href="/users/${widget.user.id}"> ${widget.user.name} </a></td></tr>`)
            });
            // $('#check-email-status').empty();
            console.log(data)
        })
    });
});