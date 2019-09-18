$(document).ready(function() {

    let canvas = document.getElementById('playground');
    let ctx = canvas.getContext('2d');
    let top_padding = 30;
    let deltatime = 20;
    let messages = [];

    let record = document.getElementById('messages_record');
    let contain_convas = document.getElementById('contain_canvas');

    setInterval(draw, deltatime);

    let chatSocket = new WebSocket(
        'wss://' + window.location.host +
        '/wss/danmu/' + roomName + '/');

    chatSocket.onmessage = function(e) {
        let data = JSON.parse(e.data);
        let activity = data['activity'];
        if (activity === 'chat'){
            let message = data['message'];
            let time = data['time'];
            add(message);
            add_to_record(message, time);
        }
        else if (activity === 'joinin' || activity === 'checkout'){
            let amount = data['amount'];
            if (amount < 1){
                amount = 1;
            }
            $('#amount_of_people').text(amount);
            if (activity === 'joinin') {
                add('欢迎新同学加入~~');
            }
        }
        else if (activity === 'history'){
            messages = data['messages'];
            for (i = 0; i < messages.length; i ++ ){
                add_to_record(messages[i][0], messages[i][1]);
            }
        }
    };

    chatSocket.onclose = function(e) {
        console.error('Chat socket closed unexpectedly');
    };

    document.querySelector('#chat-message-input').focus();
    document.querySelector('#chat-message-input').onkeyup = function(e) {
        if (e.keyCode === 13) {  // enter, return
            document.querySelector('#chat-message-submit').click();
        }
    };

    document.querySelector('#chat-message-submit').onclick = function(e) {
        let messageInputDom = document.querySelector('#chat-message-input');
        let message = messageInputDom.value;
        if (message.length > 0){
            chatSocket.send(JSON.stringify({
                'message': message
            }));
        }

        messageInputDom.value = '';
    };

    function add_to_record(message, time){
        record.value += '[' + time + ']' + message + '\n';
        record.scrollTop = record.scrollHeight;
    }

    function add(message){
        ctx.font = "bold 25px Courier New";
        let msg = {
            value: message,
            x: canvas.width,
            y: parseInt(Math.random() * (canvas.height - top_padding)) + top_padding,
            speed: 70,
            color: 'white',
            width: ctx.measureText(message).width + 10,
            height: parseInt(25 * 1.2)
        };
        messages.push(msg);
    }

    function draw() {
        for (let i = 0; i < messages.length; i ++ ){
            let msg = messages[i];
            ctx.clearRect(Math.max(0, msg.x + msg.speed / 1000), Math.max(0, msg.y - msg.height), msg.x + msg.speed / 1000+ msg.width, msg.y);
        }
        ctx.beginPath();
        for (let i = messages.length - 1; i >= 0; i -- ) {
            let msg = messages[i];
            ctx.fillStyle = msg.color;
            ctx.font = "bold 25px Courier New";
            ctx.fillText(msg.value, msg.x, msg.y);
            ctx.closePath();
            messages[i].x -= msg.speed / 1000 * deltatime;
            if (messages[i].x < -msg.width - 10) {
                messages.splice(i, 1);
            }
        }
    }
});