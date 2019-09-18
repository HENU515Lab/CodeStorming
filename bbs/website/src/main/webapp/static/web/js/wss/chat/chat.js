$(document).ready(function () {
    let chatSocket = new WebSocket(
        'wss://' + window.location.host +
        '/wss/chat/');

    chat_state.chat_socket = chatSocket;

    chatSocket.onmessage = function(e) {
        let data = JSON.parse(e.data);
        let activity = data['activity'];
        if (activity === 'message_history'){
            handle_message_history(data);
        }
        else if (activity === 'send_message'){
            handle_send_message(data);
        }
        else if (activity === 'add_friend'){
            handle_add_friend(data);
        }
        else if (activity === 'pull_message'){
            handle_pull_message(data);
        }
        else if (activity === 'broadcast_online_status'){
            handle_broadcast_online_status(data);
        }
        else if (activity === 'problem_submit_code_status'){
            handle_problem_submit_code_status(data);
        }
        else if (activity === 'problem_run_code_status'){
            handle_problem_run_code_status(data);
        }
        else if (activity === 'chat_problem_run_code_status') {
            handle_chat_problem_run_code_status(data);
        }
        else if (activity === 'third_party_weixin_pay_notify_user_result') {
            handle_third_party_weixin_pay_notify_user_result(data);
        }
        else if (activity === 'activity_aclass_send_message') {
            handle_activity_aclass_send_message(data);
        }
        else if (activity === 'activity_aclass_broadcast_online_status') {
            handle_activity_aclass_broadcast_online_status(data);
        }
        else if (activity === 'activity_aclass_pull_other_people_infos') {
            handle_activity_aclass_pull_other_people_infos(data);
        }
    };

    function handle_message_history(data){
        chat_state.is_ready = true;
        let friend_messages = data['messages'];
        let friends = [];

        for (let i = 0; i < friend_messages.length; i ++ ){
            let host_id = parseInt(friend_messages[i]['host_id']);
            let online_status = parseInt(friend_messages[i]['online_status']);
            let messages = friend_messages[i]['messages'];
            let unread_messages = parseInt(friend_messages[i]['unread_messages']);
            let messages_remains = parseInt(friend_messages[i]['messages_remains']);
            for (let j = 0; j < messages.length; j ++ ){
                let message_set = messages[j];
                let is_last_message = false;
                if (j === messages.length - 1) is_last_message = true;
                let type = parseInt(message_set['type']);
                let message = message_set['message'];
                let message_tuple = [type, message];
                if (type === 2) {
                    let code = message_set['code'];
                    let language = message_set['language'];
                    message_tuple.push(code);
                    message_tuple.push(language);
                }
                else if (type === 3) {
                    let url = message_set['url'];
                    let description = message_set['description'];
                    message_tuple.push(url);
                    message_tuple.push(description);
                }
                add_message_to_host(message_tuple, parseInt(message_set['sender']), host_id, message_set['createtime'], is_last_message);
            }
            if (chat_state.now_host_id === host_id && get_chat_room_state() === 2){
                chat_state.host_unread_messages[host_id] = 0;
                if (unread_messages > 0){
                    chatSocket.send(JSON.stringify({
                        'activity': "read_message",
                        'host_id': host_id
                    }));
                }
            }
            else{
                chat_state.host_unread_messages[host_id] = unread_messages;
                chat_state.total_unread_messages += unread_messages;
                update_notification_number(host_id);
            }
            chat_state.host_messages_remains[host_id] = messages_remains;

            friends.push({
                "online_status": online_status,
                "createtime": chat_state.host_last_record_time[host_id],
                "host_id": host_id,
            });

            chat_state.host_online_status[host_id] = online_status;
            if (online_status === 1) {
                $('#chat-list-status-' + host_id).show();
                chat_state.total_online_friends += 1;
            }

            let $chat_list_username = $('#chat-list-username-' + host_id);
            let $username = $chat_list_username.text().trim();
            if ($username.length > 10) $chat_list_username.text($username.substr(0, 10) + "...");
        }

        friends.sort(function (a, b) {
            let online_status_a = a["online_status"];
            let online_status_b = b["online_status"];
            if (online_status_a < online_status_b) return -1;
            if (online_status_a > online_status_b) return 1;
            let ta = new Date(a["createtime"]);
            let tb = new Date(b["createtime"]);
            if (ta < tb) return -1;
            if (ta === tb) return 0;
            return 1;
        });

        for (let i = 0; i < friends.length; i ++ ) {
            let host_id = friends[i]["host_id"];
            move_to_right_position_in_friend_list(host_id);
        }

        setInterval(function() {
            chatSocket.send(JSON.stringify({
                'activity': "heartbeat"
            }));
        }, 30000);
    }

    function handle_send_message(data){
        let type = parseInt(data['type']);
        let message = data['message'];
        let message_tuple = [type, message];
        if (type === 2) {
            let code = data['code'];
            let language = data['language'];
            message_tuple.push(code);
            message_tuple.push(language);
        }
        else if (type === 3) {
            let url = data['url'];
            let description = data['description'];
            message_tuple.push(url);
            message_tuple.push(description);
        }
        let from_id = parseInt(data['from_id']);
        let to_id = parseInt(data['to_id']);
        if (from_id !== chat_state.me_id){
            add_message_to_host(message_tuple, 2, from_id, data['createtime']);
            notification_user(message, from_id);
            move_to_right_position_in_friend_list(from_id);
        }
        else{
            add_message_to_host(message_tuple, 1, to_id, data['createtime']);
            move_to_right_position_in_friend_list(to_id);
        }
    }

    function handle_add_friend(data) {
        let host_id = parseInt(data['applicant_id']);
        let host_photo_url = data['applicant_photo_url'];
        let host_space_url = data['applicant_space_url'];
        let host_username = data['applicant_username'];
        let friend_createtime = data['friend_createtime'];
        let friend_online_status = data['friend_online_status'];
        let request_from_me = parseInt(data['request_from_me']);

        if (host_id in chat_state.host_usernames) return;

        if (host_username.length > 10) {
            host_username = host_username.substr(0, 10) + "...";
        }

        $template_chat_list_friend = $('#template_chat_list_friend').html()
            .replace("O_host_id_O", host_id)
            .replace("O_host_id_1", host_id)
            .replace("O_host_id_2", host_id)
            .replace("0_host_id_3", host_id)
            .replace("0_host_id_4", host_id)
            .replace("https://www.acwing.com/static/web/img/favicon.ico", host_photo_url)
            .replace("O_host_username_O", host_username);
        $('#chat-friend-list').prepend($template_chat_list_friend);

        chat_state.host_messages[host_id] = [];
        chat_state.host_online_status[host_id] = friend_online_status;
        chat_state.host_online_has_set_disconnected[host_id] = false;
        chat_state.host_last_record_time[host_id] = friend_createtime;
        chat_state.host_photo_urls[host_id] = host_photo_url;
        chat_state.host_space_urls[host_id] = host_space_url;
        chat_state.host_usernames[host_id] = host_username;
        chat_state.host_messages_remains[host_id] = 0;
        chat_state.host_unread_messages[host_id] = 0;

        let get_into_room = function(){
            $('#chat_room_body').show('fast', function () {
                $('#message_send_input').focus();
            });

            init_the_room(host_id);
            clear_notification_number(host_id);
            return false;
        };

        chat_state.host_get_into_room_functions[host_id] = get_into_room;

        $('#chat_friend_' + host_id).click(get_into_room);

        // 被动添加好友不需要打开聊天框
        if (request_from_me === 1){
            chat_state.host_get_into_room_functions[host_id]();
        }

        $('#chat_list_no_friends_notice').hide();
        if (friend_online_status === 1) {
            $('#chat-list-status-' + host_id).show();
            chat_state.total_online_friends += 1;
        }

        move_to_right_position_in_friend_list(host_id);
    }

    function handle_pull_message(data){
        let messages = data['messages'];
        let host_id = parseInt(data['host_id']);
        let messages_remains = parseInt(data['messages_remains']);
        for (let i = messages.length - 1; i >= 0; i--){
            let message = messages[i];
            let msg = {
                type: parseInt(message['type']),
                message: message['message'],
            };
            if (msg.type === 2) {
                msg.code = message['code'];
                msg.language = message['language'];
            }
            else if (msg.type === 3) {
                msg.url = message['url'];
                msg.description = message['description'];
            }
            pull_message_from_server(msg, parseInt(message['sender']), host_id, message['createtime']);
        }
        let $message_field = [];
        let last_record_time = "";
        for (let i = 0; i < messages.length; i++){
            let type = parseInt(messages[i]['type']);
            let message = messages[i]['message'];
            let sender = messages[i]['sender'];
            let photo_url = chat_state.host_photo_urls[host_id];
            let space_url = chat_state.host_space_urls[host_id];
            let createtime = messages[i]['createtime'];
            if (is_time_show(last_record_time, createtime)) {
                last_record_time = createtime;
                createtime = get_nice_time(createtime);
                let $message_create_time = $('#message_create_time')
                                .html().replace("message create time", createtime);
                $message_field.push([0, $message_create_time]);     // 0 用来占位置，表示message type
            }

            chat_state.unique_message_id ++;
            let $message_id = chat_state.unique_message_id;

            let $message_code_template = $('#message_code_template');
            let $message_emoji_gif_template = $('#message_emoji_gif_template');
            let args0 = "";
            let args1 = "";
            if (type === 2) {
                args0 = messages[i]['code'];
                args1 = messages[i]['language'];
            }
            else if (type === 3) {
                args0 = messages[i]['url'];
                args1 = messages[i]['description'];
            }
            if (sender === 1){
                let $message_content_template = $('#message_template_me')
                                .html()
                                .replace("https://www.acwing.com/static/web/img/favicon.ico", chat_state.host_photo_urls[chat_state.me_id])
                                .replace("https://message_host_space_url", chat_state.host_space_urls[chat_state.me_id]);
                if (type === 1) {
                    $message_content_template = $message_content_template.replace("message_content", message);
                }
                else if (type === 2) {
                    $message_code_template = $message_code_template
                        .html()
                        .replace("0_message_id_0", $message_id.toString());
                    $message_content_template = $message_content_template.replace("message_content", $message_code_template);
                }
                else if (type === 3) {
                    $message_emoji_gif_template = $message_emoji_gif_template
                        .html()
                        .replace("https://www.acwing.com/static/web/img/favicon.ico", args0)
                        .replace("emoji_gif_description", args1);
                    $message_content_template = $message_content_template
                        .replace("message_content", $message_emoji_gif_template)
                        .replace("chat-bubble-me", "");
                }
                $message_field.push([type, $message_content_template, $message_id, args0, args1]);
            }
            else {
                let $message_content_template = $('#message_template_you')
                                .html()
                                .replace("https://www.acwing.com/static/web/img/favicon.ico", photo_url)
                                .replace("https://message_host_space_url", space_url);
                if (type === 1) {
                    $message_content_template = $message_content_template.replace("message_content", message);
                }
                else if (type === 2) {
                    $message_code_template = $message_code_template
                        .html()
                        .replace("0_message_id_0", $message_id.toString());
                    $message_content_template = $message_content_template.replace("message_content", $message_code_template);
                }
                else if (type === 3) {
                    $message_emoji_gif_template = $message_emoji_gif_template
                        .html()
                        .replace("https://www.acwing.com/static/web/img/favicon.ico", args0)
                        .replace("emoji_gif_description", args1);
                    $message_content_template = $message_content_template
                        .replace("message_content", $message_emoji_gif_template)
                        .replace("chat-bubble-you", "");
                }
                $message_field.push([type, $message_content_template, $message_id, args0, args1]);
            }
        }

        let $chat_message_history_field = $('#chat_message_history_field');
        let scroll_bottom = $chat_message_history_field[0].scrollHeight - $chat_message_history_field.scrollTop();
        for (let i = $message_field.length - 1; i >= 0; i--){
            $chat_message_history_field.prepend($message_field[i][1]);
            $chat_message_history_field.scrollTop($chat_message_history_field[0].scrollHeight - scroll_bottom);
        }
        for (let i = 0; i < $message_field.length; i++) {
            let type = $message_field[i][0];
            if (type === 2) {
                let $message_id = $message_field[i][2];
                let code = $message_field[i][3];
                let language = $message_field[i][4];

                $('#message_code_template_' + $message_id.toString()).click(function () {
                    chat_state.editor_open_from = "chat_room";
                    chat_state.editor_type = 2;

                    let code_editor = chat_state.code_editor;
                    code_editor.setValue(code, -1);

                    $('.chat_code_editor_option_language').children('select').children().filter(function() {
                        return this.text === language;
                    }).prop('selected', true);

                    let language_mapping = chat_code_editor_name_config_mappings[language];
                    code_editor.session.setMode("ace/mode/" + language_mapping);

                    $('#chat-code-editor-plugin').show();
                });
            }
        }
        chat_state.host_messages_remains[host_id] = messages_remains;
        chat_state.pulling_request_message = false;
    }

    function handle_broadcast_online_status(data) {
        let online_status = parseInt(data['online_status']);
        let host_id = parseInt(data['host_id']);

        if (online_status === 0) {
            chat_state.host_online_has_set_disconnected[host_id] = setTimeout(function () {
                if (chat_state.host_online_has_set_disconnected[host_id]) {
                    if (chat_state.host_online_status[host_id] === 1) {
                        chat_state.host_online_status[host_id] = 0;
                        chat_state.total_online_friends -= 1;
                        $('#chat-list-status-' + host_id).hide();
                        move_to_right_position_in_friend_list(host_id);
                    }
                }
            }, 5000);
        }
        else if (online_status === 1) {
            let id = chat_state.host_online_has_set_disconnected[host_id];
            if (id) {
                clearTimeout(id);
                chat_state.host_online_has_set_disconnected[host_id] = false;
            }
            if (chat_state.host_online_status[host_id] === 0) {
                chat_state.host_online_status[host_id] = 1;
                chat_state.total_online_friends += 1;
                $('#chat-list-status-' + host_id).show();
                move_to_right_position_in_friend_list(host_id);
            }
        }
    }

    let send_message = function() {
        let $message_send_input = $('#message_send_input');
        let message_content = $message_send_input.val();
        if (message_content.length > 0){
            //add_message_to_host(message_content, 1, chat_state.now_host_id, get_datetime_now());
            chatSocket.send(JSON.stringify({
                'activity': "send_message",
                'type': 1,
                'message': message_content,
                'host_id': chat_state.now_host_id
            }));
            $message_send_input.val("");
        }
        return false;
    };

    $('#message_send_btn').click(send_message);

    $('#message_send_input').keydown(function (e) {
        if (e.keyCode === 13) {
            send_message();
            return false;
        }
        return true;
    });

    onbeforeunload_functions.push(function () {
        let chat_list_state = 0;
        if ($('#chat_list_body').is(":visible")){
            chat_list_state = 1;
        }
        let chat_room_state = get_chat_room_state();
        let now_host_id = 0;
        if (chat_state.now_host_id !== ""){
            now_host_id = chat_state.now_host_id;
        }
        chatSocket.send(JSON.stringify({
            'activity': "save_chat_state",
            'chat_list_state': chat_list_state,
            'chat_room_state': chat_room_state,
            'now_host_id': now_host_id
        }));
        return false;
    });
});