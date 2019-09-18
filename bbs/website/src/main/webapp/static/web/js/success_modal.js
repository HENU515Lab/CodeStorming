$(window).on('load',function(){
    $('#modal-success').modal('show');
    setTimeout("$('#modal-success').modal('hide');", 1000);
});