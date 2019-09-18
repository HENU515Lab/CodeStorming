$(document).ready(function () {
    $('#chat_list_heading').click(function () {
        $('#chat_list_body').toggle('fast');
        return false;
    });

    $('#chat_room_heading').click(function () {
        if (user_state.is_mobile){
            return false;
        }
        let $chat_room_body = $('#chat_room_body');
        $chat_room_body.animate({height: 'toggle'}, 'fast');
        if ($chat_room_body.is(":visible")){
            $('#message_send_input').focus();
            $chat_message_history_field = $('#chat_message_history_field');
            if ($chat_message_history_field.children().length > 0){
                $chat_message_history_field.scrollTop($chat_message_history_field[0].scrollHeight);
            }
        }
        if ($chat_room_body.is(":visible")){
            clear_notification_number(chat_state.now_host_id);
        }
        return false;
    });

    $('#chat_room_btn_option').click(function () {
        $('#chat_room_btn_option_menu').toggle();
        return false;
    });

    $('#chat_room_btn_option_menu_remove').click(function () {
        $('#chat-room-modal-danger').modal('show');
        return false;
    });

    $('#confirm-host-remove-btn').click(function () {
        remove_host(chat_state.now_host_id);
    });

    $(document).click(function(event) {
        if (!$(event.target).is("#chat_room_btn_option_menu")) {
            $("#chat_room_btn_option_menu").hide();
        }
    });

    $('#chat_room_btn_remove').click(function () {
        if (get_chat_room_state() === 2 && !user_state.is_mobile) {
            $('#chat_room_body').animate({height: 'toggle'}, 'fast', function () {
                $('#chat_room').hide();
            });
        }
        else {
            $('#chat_room').hide();
        }
        return false;
    });

    let $chat_message_history_field = $('#chat_message_history_field');
    $chat_message_history_field.bind("scroll", function () {
        if ($(this).scrollTop() < 200 && !chat_state.pulling_request_message) {
            let host_id = chat_state.now_host_id;
            let first_message_id = chat_state.host_messages_remains[host_id];
            if (first_message_id !== 0){
                chat_state.pulling_request_message = true;
                chat_state.chat_socket.send(JSON.stringify({
                    'activity': "pull_request_message",
                    'host_id': host_id,
                    'first_message_id': first_message_id
                }));
            }
        }
    });

    $chat_message_history_field.on( 'mousewheel DOMMouseScroll', function ( e ) {
        let e0 = e.originalEvent;
        let delta = e0.wheelDelta || -e0.detail;
        this.scrollTop += ( delta < 0 ? 1 : -1 ) * 50;
        e.preventDefault();
    });

    let $chat_list_body = $('#chat_list_body');

    $chat_list_body.on( 'mousewheel DOMMouseScroll', function ( e ) {
        let e0 = e.originalEvent;
        let delta = e0.wheelDelta || -e0.detail;
        this.scrollTop += ( delta < 0 ? 1 : -1 ) * 50;
        e.preventDefault();
    });

    $('#chat_list_search_input').autocomplete({
        source: chat_state.search_user_url,
        delay: 0,
        minLength: 1
    }).data("ui-autocomplete")._renderItem = function (ul, item) {
        let username = item.label;
        if (username.length > 10) {
            username = username.substr(0, 10) + "...";
        }
        return $("<li style='height:40px; border-bottom: 1px'></li>")
            .click(function () {
                get_friend_information(item.host_id);
            })
            .hover(function() {
                $(this).css("background-color","#F3F4F5");
                return false;
            },function() {
                $(this).css("background-color","white");
                return false;
            })
            .data("item.autocomplete", item)
            .append("<img src='" + item.url + "' height='40px'/>")
            .append("<span style='font-weight: bold;'>" + username + "</span>")
            .appendTo(ul);
    };
});