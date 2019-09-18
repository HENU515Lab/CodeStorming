function get_datetime_now(){
    let dt = new Date();
    return dt.getFullYear() + '-' + dt.getMonth() + "-" + dt.getDate() + " " + dt.getHours() + ":" + dt.getMinutes();
}

function is_time_show(t1, t2){
    if (t1 === ""){
        return true;
    }

    let date_t1 = new Date(t1);
    let date_t2 = new Date(t2);

    if (date_t1.getMonth() !== date_t2.getMonth()
        || date_t1.getDate() !== date_t2.getDate()
            || date_t1.getHours() !== date_t2.getHours())
                return true;
    return date_t2.getMinutes() - date_t1.getMinutes() > 5;
}

function get_nice_time(t, is_short = false){
    let t1 = new Date();
    let t2 = new Date(t);
    if (t1.getFullYear() === t2.getFullYear()){
        if (t1.getMonth() === t2.getMonth() && t1.getDate() === t2.getDate()){
            return t.substr(t.indexOf(' ') + 1);
        }
        else{
            if (is_short) {
                return t.substr(5, t.length - 10).replace('-', '月').replace(' ', "日 ");
            }
            return t.substr(5).replace('-', '月').replace(' ', "日 ");
        }
    }
    if (is_short) {
        return t.substr(0, t.length - 5).replace('-', '年').replace('-', '月').replace(' ', "日 ");
    }
    return t.replace('-', '年').replace('-', '月').replace(' ', "日 ");
}

function get_chat_room_state(){
    let chat_room_state = 0;
    if ($('#chat_room').is(":visible")){
        chat_room_state = 1;
        if ($('#chat_room_body').is(":visible")){
            chat_room_state = 2;
        }
    }
    return chat_room_state;
}

function init_the_room(host_id){
    $('#chat_room').show();
    let $chat_room_host = $('#chat_room_host');
    $chat_room_host.text(chat_state.host_usernames[host_id]);
    $('#chat-room-notification-number').css({left: 10 + $chat_room_host.width()});

    if (chat_state.now_host_id !== host_id){
        chat_state.now_host_id = host_id;
        $('#chat_message_history_field').empty();
        chat_state.last_record_time = "";

        for (let $i = 0; $i < chat_state.host_messages[chat_state.now_host_id].length; $i ++ ){
            let $message = chat_state.host_messages[chat_state.now_host_id][$i];
            let msg = [$message.type, $message.message];
            if ($message.type === 2) {
                msg.push($message.code);
                msg.push($message.language);
            }
            else if ($message.type === 3) {
                msg.push($message.url);
                msg.push($message.description);
            }
            if ($message.sender === 1){
                add_message(msg, $message.sender, chat_state.host_photo_urls[chat_state.me_id],
                                chat_state.host_space_urls[chat_state.me_id], $message.createtime);
            }
            else{
                add_message(msg, $message.sender, chat_state.host_photo_urls[chat_state.now_host_id],
                                chat_state.host_space_urls[chat_state.now_host_id], $message.createtime);
            }
        }
    }
    return false;
}

function pull_message_from_server(message, sender, host_id, createtime){
    if (host_id in chat_state.host_messages){
        let msg = {
            type: message.type,
            message: message.message,
            sender: sender,
            createtime: createtime
        };
        if (message.type === 2) {
            msg.code = message.code;
            msg.language = message.language;
        }
        else if (message.type === 3) {
            msg.url = message.url;
            msg.description = message.description;
        }
        chat_state.host_messages[host_id].unshift(msg);
    }
}

function  move_to_right_position_in_friend_list(host_id) {
    let cur = $('#chat-friend-list-element-' + host_id);
    let online_status = chat_state.host_online_status[host_id];
    if (online_status === 1) {
        cur.prependTo('#chat-friend-list-online');
    }
    else if (online_status === 0) {
        cur.prependTo('#chat-friend-list');
    }
}

function add_message_to_host(message_tuple, sender, host_id, createtime, is_last_message=true){
    if (host_id in chat_state.host_messages){
        let type = message_tuple[0];
        let message = message_tuple[1];
        let msg = {
            type: type,
            message: message,
            sender: sender,
            createtime: createtime
        };
        if (type === 2) {
            msg.code = message_tuple[2];
            msg.language = message_tuple[3];
        }
        else if (type === 3) {
            msg.url = message_tuple[2];
            msg.description = message_tuple[3];
        }
        chat_state.host_messages[host_id].push(msg);
        if (host_id === chat_state.now_host_id){
            if (sender === 1){
                add_message(message_tuple, sender, chat_state.host_photo_urls[chat_state.me_id], chat_state.host_space_urls[chat_state.me_id], createtime);
            }
            else{
                add_message(message_tuple, sender, chat_state.host_photo_urls[host_id], chat_state.host_space_urls[host_id], createtime);
            }
        }
        if (is_last_message) {
            $('#chat_list_message_time_' + host_id).text(get_nice_time(createtime, true));
            chat_state.host_last_record_time[host_id] = createtime;
        }
        if (sender === 1){
            //message = "你: " + message;
            if (message.length > 8) message = message.substr(0, 8) + "...";
            $('#chat_list_friend_' + host_id).text(message);
        }
        else{
            //message = chat_state.host_usernames[host_id] + ": " + message;
            if (message.length > 8) message = message.substr(0, 8) + "...";
            $('#chat_list_friend_' + host_id).text(message);
        }
    }
}

function add_message(message_tuple, sender, photo_url, space_url, createtime){
    let $message_field = $('#chat_message_history_field');
    let type = message_tuple[0];
    let message = message_tuple[1];
    if (is_time_show(chat_state.last_record_time, createtime)) {
        chat_state.last_record_time = createtime;
        createtime = get_nice_time(createtime);
        let $message_create_time = $('#message_create_time')
                        .html().replace("message create time", createtime);
        $message_field.append($message_create_time);
    }

    chat_state.unique_message_id ++;
    let $message_id = chat_state.unique_message_id;

    let $message_code_template = $('#message_code_template');
    let $message_emoji_gif_template = $('#message_emoji_gif_template');
    if (sender === 1){
        let $message_content_template = $('#message_template_me').
                        html()
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
            let url = message_tuple[2];
            let description = message_tuple[3];
            $message_emoji_gif_template = $message_emoji_gif_template
                .html()
                .replace("https://www.acwing.com/static/web/img/favicon.ico", url)
                .replace("emoji_gif_description", description);
            $message_content_template = $message_content_template
                .replace("message_content", $message_emoji_gif_template)
                .replace("chat-bubble-me", "");
        }
        $message_field.append($message_content_template);
    }
    else {
        let $message_content_template = $('#message_template_you').
                        html()
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
            let url = message_tuple[2];
            let description = message_tuple[3];
            $message_emoji_gif_template = $message_emoji_gif_template
                .html()
                .replace("https://www.acwing.com/static/web/img/favicon.ico", url)
                .replace("emoji_gif_description", description);
            $message_content_template = $message_content_template
                .replace("message_content", $message_emoji_gif_template)
                .replace("chat-bubble-you", "");
        }
        $message_field.append($message_content_template);
    }

    if (type === 2) {
        let code = message_tuple[2];
        let language = message_tuple[3];

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

    $message_field.scrollTop($message_field[0].scrollHeight);
}

function get_friend_information(host_id){
    if (host_id === chat_state.me_id) return;

    if (host_id in chat_state.host_usernames){
        chat_state.host_get_into_room_functions[host_id]();
    }
    else{
        chat_state.chat_socket.send(JSON.stringify({
            'activity': "add_friend",
            'host_id': host_id
        }));
    }
}

function remove_host(host_id){

    if (chat_state.host_online_status[host_id] === 1) {
        chat_state.total_online_friends -= 1;
    }

    $('#chat_friend_' + host_id).remove();

    delete chat_state.host_messages[host_id];
    delete chat_state.host_online_status[host_id];
    delete chat_state.host_online_has_set_disconnected[host_id];
    delete chat_state.host_last_record_time[host_id];
    delete chat_state.host_photo_urls[host_id];
    delete chat_state.host_space_urls[host_id];
    delete chat_state.host_usernames[host_id];
    delete chat_state.host_messages_remains[host_id];
    delete chat_state.host_unread_messages[host_id];
    delete chat_state.host_get_into_room_functions[host_id];
    chat_state.now_host_id = "";

    if (get_chat_room_state() === 2 && !user_state.is_mobile) {
        $('#chat_room_body').animate({height: 'toggle'}, 'fast', function () {
            $('#chat_room').hide();
        });
    }
    else {
        $('#chat_room').hide();
    }

    chat_state.chat_socket.send(JSON.stringify({
        'activity': "remove_friend",
        'host_id': host_id
    }));

    let friend_count = chat_state.host_usernames.filter(function (x) {
        return true;
    }).length;

    if (friend_count <= 1){
        $('#chat_list_no_friends_notice').show();
    }
}