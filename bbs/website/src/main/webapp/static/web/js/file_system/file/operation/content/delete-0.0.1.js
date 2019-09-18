function setDeleteUrl(delete_url) {
    $('#modal_danger_delete_url').attr('action', delete_url);
}

$(document).ready(function () {
    let $btn = $('#modal_danger_delete_url_btn');

    $btn.on("click", function(){
        let $form = $('#modal_danger_delete_url');
        let postData = $form.serializeArray();
        let formUrl = $form.attr("action");

        if (formUrl.indexOf("comment") >= 0) return;

        $.ajax({
            url: formUrl,
            type: "POST",
            data: postData,
            dataType: "Json",
            cache: false,
            timeout: 60000,
            success: function(resp){
                if (resp.error_message === "success"){
                    window.location.href = '/';
                }
            },
            error: function(){
            }
        });

        return true;
    });
});