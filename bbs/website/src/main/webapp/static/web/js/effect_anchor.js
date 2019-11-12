$(document).ready(function () {

    function highlight(href){
        let anchor_pos = href.indexOf("#");
        if (anchor_pos !== -1) {
            let anchor_id = href.substr(anchor_pos + 1);
            if (anchor_id.length > 0){
                let $anchor = $('#' + anchor_id);
                let elOffset = $anchor.offset().top;
                let elHeight = $anchor.height();
                let windowHeight = $(window).height();
                let offset;

                if (elHeight < windowHeight) {
                offset = elOffset - ((windowHeight / 2) - (elHeight / 2));
                }
                else {
                offset = elOffset;
                }
                $('html').animate({scrollTop:offset}, 500, function () {
                    $anchor.effect('pulsate', 'slow');
                });
            }
        }
    }

    // 最开始js负载较大，画面会卡
    setTimeout(function () {
        highlight(location.href);
    }, 0);

    $('a.comment_link').click(function(){
        let href = $(this).attr('href');
        highlight(href);
        return false;
    });
});