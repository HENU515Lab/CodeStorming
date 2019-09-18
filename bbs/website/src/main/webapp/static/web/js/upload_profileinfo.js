$(function() {
    $('#form_upload_profileinfo').submit(function () {
        var postData = $(this).serializeArray();
        var formUrl = $(this).attr("action");

        $.ajax({
            url: formUrl,
            type: "POST",
            data: postData,
            dataType: "Json",
            cache: false,
            timeout: 60000,
            success: function(resp){
                if (resp.error_message === "success"){
                    $('#id_user_username').html(resp.username);
                    $('#success_message_content').html("信息更新成功");
                    $('#error_message_content').html("");
                    $('#modal-success').modal('show');
                    //setTimeout("$('#modal-success').modal('hide');", 1000);
                }
                else {
                    $('#error_message_content').html(resp.error_message);
                }
            },
            error: function(){
            }
        });

        return false;
    });
});