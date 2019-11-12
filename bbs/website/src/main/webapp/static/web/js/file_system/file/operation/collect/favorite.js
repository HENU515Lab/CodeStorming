$(function () {
    $('form.form_favorte').on("submit", function (e) {
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
                let $span_cnt = $('span.' + $id + '_favorite');
                if (resp.error_message === "add_success"){
                    $span.addClass('favorite');
                    $span_cnt.addClass('favorite_number');
                    $span_cnt.text(resp.favoritecnt);
                }
                else if (resp.error_message === 'remove_success'){
                    $span.removeClass('favorite');
                    $span_cnt.removeClass('favorite_number');
                    $span_cnt.text(resp.favoritecnt > 0 ? resp.favoritecnt : '');
                }
            },
            error: function(){
            }
        });

        return false;
    });
});