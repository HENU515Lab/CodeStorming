let handle_chat_problem_run_code_status = function(data){
    let status = data['status'];
    let $stderr = data['stderr'];
    let $status_value = $('#chat_run-code-status-value-id');
    $status_value.text(code_status_names[status]);
    $status_value.css('color', code_status_colors[$status_value.text()]);
    let $run_code_stdout = $('#chat_run-code-stdout');
    if (status === 'COMPILE_ERROR'){
        $run_code_stdout.text(data['compilation_log']);
    }
    else if ((typeof $stderr !== "undefined") && $stderr.length > 0) {
        $run_code_stdout.text($stderr);
    }
    else{
        $run_code_stdout.text(data['stdout']);
    }

    if ('time' in data){
        let $run_code_time = $('#chat_run-code-time');
        $run_code_time.show();
        $run_code_time.text("运行时间：" + data['time'] + "ms");
    }

    if (status !== 'Uploading' && status !== 'Pending' && status !== 'Running'){
        $('#chat_run-code-status-loading-gif-id').hide();
        $('#chat_submit_code_btn').removeClass('disabled');
        $('#chat_run_code_btn').removeClass('disabled');
    }
};


$(document).ready(function () {

    let measurer = $('<pre>',{
        style: "display:inline-block;word-break:break-word;visibility:hidden;white-space:pre-wrap;position:absolute;left:0;top:0;z-index:-1;"
    }).appendTo('#chat-code-editor-plugin-body');

    function initMeasurerFor(textarea){
        measurer.text(textarea.text())
            .css("width", textarea.width() + "px")
            .css('font',textarea.css('font'))
            .css("padding", textarea.css("padding"))
            .css("min-height", textarea.css('min-height'))
    }

    function updateTextAreaSize(textarea){
        textarea.height(measurer.height());
    }

    let $textarea = $('textarea.chat_autofit');

    $('#chat_run_code_btn').click(function () {

        if ($(this).hasClass('disabled')){
            return false;
        }
        $('#chat_submit_code_btn').addClass('disabled');
        $(this).addClass('disabled');

        $('#chat_submit-code-status-block').hide();
        $('#chat_run-code-status-block').show();
        $('#chat_run-code-status-loading-gif-id').show();

        let $status_value = $('#chat_run-code-status-value-id');
        $status_value.text('Uploading');
        $status_value.css('color', code_status_colors[$status_value.text()]);
        $('#chat_run-code-stdout').text('');
        $('#chat_run-code-time').hide();

        chat_state.chat_socket.send(JSON.stringify({
            'activity': "problem_run_code",
            'problem_id': -1,
            'code': ace.edit("chat_code_editor").getValue(),
            'language': $('.chat_code_editor_option_language').children('select').children(':selected').text(),
            'input': $('#chat_run-code-stdin').val(),
        }));

        let $editor_panel_body = $('#chat-code-editor-plugin-body');
        $editor_panel_body.animate({scrollTop: $editor_panel_body[0].scrollHeight}, 'slow');

        return false;
    });

    $('#code-editor-close-btn').click(function () {
        if (chat_state.editor_type === 1) {
            chat_state.editor_save_code();
        }

        $('#chat-code-editor-plugin').hide();
        return false;
    });

    $('#chat_submit_code_btn').click(function () {
        if (chat_state.editor_type === 1) {
            chat_state.editor_save_code();
        }

        if (chat_state.editor_open_from === "chat_room") {
            chat_state.chat_socket.send(JSON.stringify({
                'activity': "send_message",
                'type': 2,
                'code': ace.edit("chat_code_editor").getValue(),
                'language': $('.chat_code_editor_option_language').children('select').children(':selected').text(),
                'host_id': chat_state.now_host_id
            }));
        } else if (chat_state.editor_open_from === "aclass_chat_room") {
            chat_state.chat_socket.send(JSON.stringify({
                'activity': "activity_aclass_send_message",
                'type': 2,
                'code': ace.edit("chat_code_editor").getValue(),
                'language': $('.chat_code_editor_option_language').children('select').children(':selected').text(),
                'host_id': chat_state.now_host_id
            }));
        }

        $('#chat-code-editor-plugin').hide();

        return false;
    });

    let has_init_measurer = false;
    $textarea.on({
        input: function(){
            let text = $(this).val();
            if($(this).attr("preventEnter") === undefined){
                text = text.replace(/[\n]/g, "<br>&#8203;");
            }
            measurer.html(text);
            updateTextAreaSize($(this));
        },
        focus: function () {
            if (!has_init_measurer) {
                initMeasurerFor($textarea);
                updateTextAreaSize($textarea);
                has_init_measurer = true;
            }
        }
    });
});