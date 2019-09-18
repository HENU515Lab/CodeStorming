function setDeleteUrl(delete_url) {
    $('#modal_danger_delete_url').attr('action', delete_url);
}

$(function () {
    $btn = $('#modal_danger_delete_url_btn');

    $btn.on("click", function(){
        var $form = $('#modal_danger_delete_url');
        var postData = $form.serializeArray();
        var formUrl = $form.attr("action");

        $.ajax({
            url: formUrl,
            type: "POST",
            data: postData,
            dataType: "Json",
            cache: false,
            timeout: 60000,
            success: function(resp){
                if (resp.error_message === "success"){
                    window.location.href = user_myspace_index_url;
                }
                else if (resp.error_message === "comment_delete_success"){
                    window.location.href = solution_leetcode_content;
                }
                else {
                    window.location.href = solution_leetcode_content;
                }
            },
            error: function(){
            }
        });

        return true;
    });
});