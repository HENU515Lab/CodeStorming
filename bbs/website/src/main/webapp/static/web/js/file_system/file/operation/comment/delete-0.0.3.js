let GLOBAL_FILE_OPERATION_DELETE_FILE_ID = 0;

function setDeleteUrl(delete_url, file_id) {
    $('#modal_danger_delete_url').attr('action', delete_url);
    GLOBAL_FILE_OPERATION_DELETE_FILE_ID = file_id;
}

$(document).ready(function () {

    let delete_cnt = 0;

    let delete_comment = function (cid) {   // 递归删除整棵评论树
        let $cmt = $('#comment_' + cid);
        if ($cmt.length === 0) return;
        $cmt.slideUp('slow', function () {
            $cmt.remove();
        });
        delete_cnt ++ ;
        let sons = GLOBAL_COMMENT_SONS[cid];
        for (let i = 0; i < sons.length; i ++ )
            delete_comment(sons[i]);
    };

    $('#modal_danger_delete_url_btn').on("click", function(){
        let $form = $('#modal_danger_delete_url');
        let postData = $form.serializeArray();
        let formUrl = $form.attr("action");

        if (formUrl.indexOf("comment") < 0) return;     // 解决与删除文章的冲突

        $.ajax({
            url: formUrl,
            type: "POST",
            data: postData,
            dataType: "Json",
            cache: false,
            timeout: 60000,
            success: function(resp){
                if (resp.error_message === "comment_delete_success"){
                    let cid = resp.comment_id;
                    delete_cnt = 0;
                    delete_comment(cid);
                    let $commentcnt = $('#file_commentcnt_' + GLOBAL_FILE_OPERATION_DELETE_FILE_ID);
                    if ($commentcnt.length !== 0) {
                        let $text = $commentcnt.text().trim();
                        let cnt = parseInt($text) - delete_cnt;
                        if (cnt === 0) $commentcnt.text("评论");
                        else $commentcnt.text(cnt);
                    }
                }
            },
        });

        return true;
    });
});