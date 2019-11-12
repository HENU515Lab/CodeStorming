let window_focus = true;

$(window).focus(function() {
    window_focus = true;
}).blur(function() {
    window_focus = false;
});

function update_notification_number(host_id){
    let total = chat_state.total_unread_messages;
    let host = chat_state.host_unread_messages[host_id];
    if (total > 99) total = "99+";
    if (host > 99) host = "99+";
    $('#chat-list-title-notification-number').text(total > 0 ? total : "");
    $('#chat-list-notification-number-' + host_id).text(host > 0 ? host : "");
    if (chat_state.now_host_id === host_id){
        $('#chat-room-notification-number').text(host > 0 ? host : "");
    }
}

function clear_notification_number(host_id){
    if (chat_state.host_unread_messages[host_id] > 0){
        chat_state.total_unread_messages -= chat_state.host_unread_messages[host_id];
        chat_state.host_unread_messages[host_id] = 0;
        update_notification_number(host_id);
        chat_state.chat_socket.send(JSON.stringify({
            'activity': "read_message",
            'host_id': host_id
        }));
    }
}

function notification_user(message, from_id){

    $('#chat_message_received_audio')[0].play();

    if (chat_state.now_host_id === from_id && get_chat_room_state() === 2){
        chat_state.chat_socket.send(JSON.stringify({
            'activity': "read_message",
            'host_id': from_id
        }));
    }
    else{
        chat_state.host_unread_messages[from_id] += 1;
        chat_state.total_unread_messages += 1;
        update_notification_number(from_id);
    }

    if (window.Notification && !window_focus){
        function pop_notice(){
            if (Notification.permission === "granted"){
                let notification = new Notification(chat_state.host_usernames[from_id], {
                    body: message,
                    icon: chat_state.host_photo_urls[from_id]
                });
                notification.onshow = function() {
                   setTimeout(function() { notification.close() }, 5000);
                };
                notification.onclick = function (ev) {
                    window.focus();
                    chat_state.host_get_into_room_functions[from_id]();
                    this.close();
                };
            }
        }

        if (Notification.permission === "granted") {
            pop_notice();
        }
        else if (Notification.permission !== "denied") {
            Notification.requestPermission(function (permission) {
                pop_notice();
            });
        }
    }
}