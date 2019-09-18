$(function () {
    $('[name=notification-content-link]').on("click", function(){
        var $form = $(this).closest("form");
        var postData = $form.serializeArray();
        var formUrl = $form.attr("action");

        $notification_field_id = '#' + $(this).attr("data-parameter");

        $.ajax({
            url: formUrl,
            type: "POST",
            data: postData,
            dataType: "Json",
            cache: false,
            timeout: 60000,
            success: function(resp){
                if (resp.error_message === "success"){
                    $($notification_field_id).removeClass("notification-unread-field");
                }
                else {

                }
            },
            error: function(){
            }
        });

        return true;
    });
});