$(function () {
    $('form.form_vote').on("submit", function (e) {
        e.preventDefault();
        let $form = $(this);
        let hrefUrl = $form.attr('action');
        let postData = $form.serializeArray();
        let $id = $(this).attr('id');

        $.ajax({
            url: hrefUrl,
            type: "POST",
            data: postData,
            dataType: "Json",
            cache: false,
            timeout: 60000,
            success: function(resp){
                let $span = $('span.' + $id);
                let $span_votecnt = $('span.' + $id + '_votecnt');
                if (resp.error_message === "add_success"){
                    $span.addClass('vote_active');
                    $span_votecnt.text(resp.votecnt);
                    $id_anti = $id.replace('voteup', 'votedown');
                    if ($id.indexOf('votedown') !== -1){
                        $id_anti = $id.replace('votedown', 'voteup');
                    }
                    $span_anti = $('span.' + $id_anti);
                    $span_anti.removeClass('vote_active');
                }
                else if (resp.error_message === 'remove_success'){
                    $span.removeClass('vote_active');
                    $span_votecnt.text(resp.votecnt);
                }
                if ($id.indexOf('answer') > -1){
                    let $span_ok = $('span.' + $id + '_ok');
                    if (resp.is_accepted){
                        $span_ok.show();
                    }
                    else{
                        $span_ok.hide();
                    }
                }
            },
            error: function(){
            }
        });

        return false;
    });
});