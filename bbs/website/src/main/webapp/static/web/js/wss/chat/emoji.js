$(document).ready(function(e) {

    let block = $('#gif');
    let $message_emoticon_collection = $('#message_emoticon_collection');
    let is_searched = false, is_end = false, is_search_end = false;
    let index = 0, index2 = 0;

    let init_chat_emojis = function () {
        let cols = 9, length = CHAT_BTN_ALL_EMOJIS.length;
        let i = 0;
        let emoji_ul = $('<ul>').css("padding", "5px").css('list-style-type', "none");
        while (i < length) {
            let j = 0;
            let emoji_li = $('<li>').css("text-align", "center");
            while (j < cols && i < length) {
                emoji_li.append($('<button>')
                    .css('width', "30px")
                    .prop('title', CHAT_BTN_ALL_EMOJIS[i].description)
                    .addClass('btn btn-link emoji_btn_relative')
                    .text(CHAT_BTN_ALL_EMOJIS[i].emoji));
                j ++ ;
                i ++ ;
            }
            emoji_ul.append(emoji_li);
        }
        $('#emoji').append(emoji_ul);

        $(".emoji_btn_relative").click(function(e){
            let emoji = e.target.innerHTML;
            let $message_send_input = $("#message_send_input");
            let text = $message_send_input.val();
            $message_send_input.val(text+emoji);
        });
    };

    init_chat_emojis();

    let init_chat_emoji_gifs = function(gif_id) {
        $('#' + gif_id).click(function () {
            let img = $(this).children(0);
            chat_state.chat_socket.send(JSON.stringify({
                'activity': "send_message",
                'type': 3,
                'url': img.attr('src'),
                'description': img.prop('title'),
                'host_id': chat_state.now_host_id,
            }));

            if(!$message_emoticon_collection.hasClass("hide")){
                $message_emoticon_collection.hide().addClass("hide");
                $('#gif_search_input').val("");
            }
            return false;
        });
    };

    let gif_unique_id = 0;
    let draw_chat_emoji_gifs = function(data) {
        for(let i = 0; i < data.urls.length; i ++ ){
            let gif_id = "emoji_gif_id_" + gif_unique_id;
            block.append($('<button>')
                .attr('id', gif_id)
                .addClass('btn btn-link')
                .append($('<img>')
                    .attr('src', data.urls[i])
                    .prop('title', data.descriptions[i])
                    .width(132)
                )
            );
            init_chat_emoji_gifs(gif_id);
            gif_unique_id ++ ;
        }
    };

    $('#message_emoticon_btn').click(function(e) {
        event.stopPropagation();
        if($message_emoticon_collection.hasClass("hide")){
            $message_emoticon_collection.show().removeClass("hide");
            $.ajax({
                method:"GET",
                url : chat_state.emoji_gif_data_url + "?data="+0,
                dataType:"Json",
                success: function(data){
                    block.scrollTop(0);
                    block.empty();
                    draw_chat_emoji_gifs(data);
                    is_searched = false;
                    is_end = false;
                    index = 1;
                }
            });
        }else{
            $message_emoticon_collection.hide().addClass("hide");
            $('#gif_search_input').val("");
        }
    });

    let time = 1;
    $("#gif_search_input").bind("input propertychange",function () {
        clearTimeout(time);
        time = setTimeout(function(){
            $.ajax({
                method:"POST",
                data: $('#gif_search_form').serialize() ,
                dataType:"Json",
                url: chat_state.emoji_gif_search_url + "?data="+0,
                success:function(data){
                    block.empty();
                    draw_chat_emoji_gifs(data);
                    is_searched = true;
                    index2 = 1;
                    is_search_end = false;
                }
            });
        },500);
    });

    $('#emoji').on( 'mousewheel DOMMouseScroll', function ( e ) {
        let e0 = e.originalEvent;
        let delta = e0.wheelDelta || -e0.detail;
        this.scrollTop += ( delta < 0 ? 1 : -1 ) * 50;
        e.preventDefault();
    });

    block.on( 'mousewheel DOMMouseScroll', function ( e ) {
        let e0 = e.originalEvent;
        let delta = e0.wheelDelta || -e0.detail;
        this.scrollTop += ( delta < 0 ? 1 : -1 ) * 50;
        e.preventDefault();
    });

    block.scroll( function () {
        if(!is_searched){
            if (block.scrollTop() + 1 >= block[0].scrollHeight - block.outerHeight() && !is_end){
                $.ajax({
                    method:"GET",
                    url : chat_state.emoji_gif_data_url + "?data=" + index,
                    dataType:"Json",
                    success: function(data){
                        draw_chat_emoji_gifs(data);
                        if (data.urls.length < 20) is_end = true;
                        index ++ ;
                    }
                });
            }
        }else{
            if (block.scrollTop() + 1 >= block[0].scrollHeight-block.outerHeight() && !is_search_end){
                $.ajax({
                    method:"POST",
                    data: $('#gif_search_form').serialize() ,
                    dataType:"Json",
                    url: chat_state.emoji_gif_search_url + "?data=" + index2,
                    success:function(data){
                        draw_chat_emoji_gifs(data);
                        if(data.urls.length < 20) is_search_end = true;
                        index2 ++ ;
                    }
                });
            }
        }
    });

    $('body').click(function(e){
        let elem = e.target || e.srcElement;
        while (elem) {
			if (elem.id && elem.id === 'message_emoticon_collection') {
				return;
			}
			elem = elem.parentNode;
		}
        if(!$message_emoticon_collection.hasClass("hide")){
            $message_emoticon_collection.hide().addClass("hide");
            $('#gif_search_input').val("");
        }
    });
});