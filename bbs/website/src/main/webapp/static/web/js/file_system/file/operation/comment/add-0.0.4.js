let GLOBAL_FILE_OPERATION_ADD_FILE_ID = 0;

let GLOBAL_FILE_COMMENT_ADD_FUNCTION = function(e) {
    e.preventDefault();

    let $form = $(this);
    let postData = $form.serializeArray();
    let formUrl = $form.attr("action");
    let id = $(this).attr('id');
    let $modal_warning = $('#modal-warning');
    let $warning_message_content = $('#warning_message_content');

    $.ajax({
        url: formUrl,
        type: "POST",
        data: postData,
        dataType: "Json",
        cache: false,
        timeout: 60000,
        success: function (resp) {
            if (resp.error_message === "success") {
                let html = resp.html_content;
                if (id.indexOf("comment_reply_form_top") >= 0)
                    $('#' + id.replace("comment_reply_form_top_", "comment_list_field_")).prepend(html);
                else {
                    let $pmt_id = id.replace("_reply_form", "");
                    $("#" + id.replace("form", "btn"))
                        .text(function (i, text) {
                            return text === "回复" ? "收起" : "回复";
                        });
                    $form.toggle(0, function () {
                        $('#' + $pmt_id).after(html);
                    });
                }

                let $cmt = $('#comment_' + resp.comment_id);
                $cmt.effect('pulsate', 'slow');

                let $commentcnt = $('#file_commentcnt_' + GLOBAL_FILE_OPERATION_ADD_FILE_ID);
                if ($commentcnt.length !== 0) {
                    let $text = $commentcnt.text().trim();
                    if ($text === "评论") $commentcnt.text("1");
                    else $commentcnt.text(parseInt($text) + 1);
                }
                $form.children().eq(1).val("");
            } else if (resp.error_message === "comment not exists") {
                $warning_message_content.text("您回复的评论不存在, 请刷新页面后重试");
                $modal_warning.modal('show');
            } else if (resp.error_message === "file not exists") {
                $warning_message_content.text("文章已被作者删除, 请刷新页面后重试");
                $modal_warning.modal('show');
            }
        },
    });
};