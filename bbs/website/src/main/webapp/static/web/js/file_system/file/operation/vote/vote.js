$(function () {
    $('form.form_vote').on("submit", function (e) {
        e.preventDefault();
        let $form = $(this);
        let hrefUrl = $form.attr('action');
        // let postData = $form.children('input').attr('value')
        let postData = $form.serializeArray();
        let $id = $(this).attr('id');
        $.ajax({
            url: hrefUrl,
            type: "POST",
            data: postData,
            dataType: "Json",
            cache: false,
            timeout: 60000,
            success: function (resp) {
                let $span = $('span.' + $id);
                let $span_votecnt = $('span.' + 'votecnt');
                if (resp.error_message === "add_success") {
                    $('span.form_votedown').removeClass('vote_active');
                    $span.addClass('vote_active');
                    $span_votecnt.text(resp.votecnt);
                    $('#vote_up_btn').removeAttr(onclick)
                } else if (resp.error_message === 'remove_success') {
                    $('span.form_voteup').removeClass('vote_active');
                    $span.addClass('vote_active');
                    $span_votecnt.text(resp.votecnt);
                    $('#vote_down_btn').removeAttr(onclick)
                } else if (resp.error_message === 'answer_add_success') {
                    $('span.answer_form_votedown_' + resp.communityAnswerId).removeClass('vote_active');
                    $('span.answer_form_voteup_' + resp.communityAnswerId).addClass('vote_active');
                    $('span.answer_votecnt_' + resp.communityAnswerId).text(resp.votecnt);
                } else if (resp.error_message === 'answer_remove_success') {
                    $('span.answer_form_voteup_' + resp.communityAnswerId).removeClass('vote_active');
                    $('span.answer_form_votedown_' + resp.communityAnswerId).addClass('vote_active');
                    $('span.answer_votecnt_' + resp.communityAnswerId).text(resp.votecnt);
                }
                if ($id.indexOf('answer') > -1) {
                    let $span_ok = $('span.' + $id + '_ok');
                    if (resp.is_accepted) {
                        $span_ok.show();
                    } else {
                        $span_ok.hide();
                    }
                }
            },
            error: function () {
            }
        });

        return false;
    });
});