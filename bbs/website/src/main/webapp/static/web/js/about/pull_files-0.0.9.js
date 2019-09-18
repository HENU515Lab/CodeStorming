$(document).ready(function () {

    let is_rendering_files = false;

    let cache_files = [];
    let batch_size = GLOBAL_FILE_COUNT;
    let begin = 0, end = GLOBAL_FILE_COUNT;
    let $field = $('#file_display_field');
    let $loading_gif = $('#loading_file_gif');

    $loading_gif.remove();

    $field.children().each(function () {
        cache_files.push($(this));
    });

    let $pull_files = function(){

        is_rendering_files = true;

        let url = GLOBAL_PULL_FILES_URL.replace("666", GLOBAL_FILE_COUNT);
        $.ajax({
            url: url,
            type: "GET",
            dataType: "Json",
            cache: false,
            timeout: 60000,
            success: function (resp) {
                if (resp.error_message === "success") {
                    GLOBAL_FILE_COUNT += resp.batch_size;
                    let htmls = resp.htmls;
                    for (let i = 0; i < htmls.length; i ++ ) {
                        $field.append(htmls[i]);
                        cache_files.push($field.children().last());
                        end ++ ;
                    }
                    let top = $(window).scrollTop();
                    while (end - begin > batch_size * 2) {
                        top -= cache_files[begin].outerHeight() + 12;
                        cache_files[begin ++ ].remove();
                        $([document.documentElement, document.body]).scrollTop(top);
                    }
                }

                $loading_gif.hide();
                $loading_gif.remove();
                is_rendering_files = false;
            },
            error: function (resp) {
                is_rendering_files = false;
                $loading_gif.hide();
                $loading_gif.remove();
            }
        });
    };

    let $render_bottom = function() {

        $field.append($loading_gif);
        $loading_gif.show();

        if (end === cache_files.length) $pull_files();
        else {
            for (let i = 0; i < batch_size && end < cache_files.length; i ++ ) {
                $field.append(cache_files[end ++ ]);
            }

            let top = $(window).scrollTop();
            while (end - begin > batch_size * 2) {
                top -= cache_files[begin].outerHeight() + 12;
                cache_files[begin ++ ].remove();
                $([document.documentElement, document.body]).scrollTop(top);
            }

            $loading_gif.hide();
            $loading_gif.remove();
            is_rendering_files = false;
        }
    };

    let $render_top = function() {

        $field.prepend($loading_gif);
        $loading_gif.show();

        let top = $(window).scrollTop();
        for (let i = 0; i < batch_size && begin > 0; i ++ ) {
            $field.prepend(cache_files[ -- begin]);
            top += cache_files[begin].outerHeight() + 12;
            $([document.documentElement, document.body]).scrollTop(top);
        }

        while (end - begin > batch_size * 2) cache_files[ -- end].remove();

        is_rendering_files = false;

        $loading_gif.hide();
        $loading_gif.remove();
    };

    $(window).scroll(function(e) {

        if (is_rendering_files) e.preventDefault();

        if(!is_rendering_files && $(window).scrollTop() + $(window).height() > $(document).height() - 20) {
            is_rendering_files = true;
            $render_bottom();
        }

        if (!is_rendering_files && $(window).scrollTop() <= 20) {
            is_rendering_files = true;
            $render_top();
        }
    });
});