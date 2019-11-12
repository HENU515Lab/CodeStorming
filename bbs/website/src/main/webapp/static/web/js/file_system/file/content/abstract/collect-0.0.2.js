let GLOBAL_FILE_COLLECT_FUNCTION = function (e) {
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
            let $star = $('span.' + $id + "_star");
            let $cnt = $('span.' + $id + '_collectcnt');
            if (resp.error_message === "add_success"){
                $star.removeClass('glyphicon-star-empty').addClass('collect-active glyphicon-star');
            }
            else if (resp.error_message === 'remove_success'){
               $star.removeClass('glyphicon-star').removeClass('collect-active').addClass('glyphicon-star-empty');
            }
            if (resp.favoritecnt > 0)
                $cnt.text(resp.favoritecnt);
            else
                $cnt.text("收藏");
        },
        error: function(){
        }
    });

    return false;
};