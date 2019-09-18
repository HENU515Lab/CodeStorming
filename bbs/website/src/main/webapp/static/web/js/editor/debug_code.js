let IS_SET_EXPECTED_STDOUT = false;

let __measurer = $('<pre>',{
    style: "display:inline-block;word-break:break-word;visibility:hidden;white-space:pre-wrap;position:absolute;left:0;top:0;z-index:-1;"
}).appendTo('body');

function __initMeasurerFor(textarea){
    __measurer.text(textarea.text())
        .css("width", textarea.width() + "px")
        .css('font',textarea.css('font'))
        .css("padding", textarea.css("padding"))
        .css("min-height", textarea.css('min-height') + "px");

    $('#run-code-status-block').hide();
}

function __updateTextAreaSize(textarea){
    textarea.height(__measurer.height());
}

let handle_problem_submit_code_status = function(data){
    let status = data['status'];
    let $stderr = data['stderr'];
    let $testcase_input = data['testcase_input'];
    let $testcase_output = data['testcase_output'];
    let $testcase_user_output = data['testcase_user_output'];
    let $status_value = $('#submit-code-status-value-id');
    $status_value.text(code_status_names[status]);
    $status_value.css('color', code_status_colors[$status_value.text()]);
    let $compilation = $('#submit-code-status-compilation-log-id');
    if (status === 'COMPILE_ERROR'){
        $compilation.show();
        $compilation.text(data['compilation_log']);
    }
    else if ((typeof $stderr !== "undefined") && $stderr.length > 0)
    {
        $compilation.show();
        $compilation.text($stderr);
    }

    if (status !== 'Uploading' && status !== 'Pending' && status !== 'Judging'){
        $('#submit-code-status-loading-gif-id').hide();
        $('#submit_code_btn').removeClass('disabled');
        $('#run_code_btn').removeClass('disabled');

        if (status !== 'ACCEPTED') {
            let $run_code_status_block = $('#run-code-status-block');
            $run_code_status_block.css('margin-top', '25px');
            $run_code_status_block.show();
            let $run_status_value = $('#run-code-status-value-id');

            // 中文字体字号要变小一点
            if ($run_status_value.hasClass("submit-code-status-value")) {
                $run_status_value.removeClass("submit-code-status-value")
                    .addClass("submit-code-status-value-chinese");
            }
            $run_status_value.text("  错误数据如下所示");
            $run_status_value.css('color', "dimgray");

            if ($testcase_input.length > 0 && $testcase_input[$testcase_input.length - 1] === '\n') {
                $testcase_input = $testcase_input.substring(0, $testcase_input.length - 1);
            }
            let $run_code_stdin = $('#run-code-stdin');
            $run_code_stdin.val($testcase_input);
            $('#run-code-stdout').text($testcase_user_output);
            $('#run-code-expected-stdout-block').show();
            $('#run-code-status-loading-gif-id').hide();
            $('#run-code-expected-stdout').text($testcase_output);

            let text = $testcase_input;
            if($run_code_stdin.attr("preventEnter") === undefined){
                text = text.replace(/[\n]/g, "<br>&#8203;");
            }
            __measurer.html(text);
            __updateTextAreaSize($run_code_stdin);

            IS_SET_EXPECTED_STDOUT = true;
        }
    }
};


let handle_problem_run_code_status = function(data){
    let status = data['status'];
    let $stderr = data['stderr'];
    let $status_value = $('#run-code-status-value-id');
    $status_value.text(code_status_names[status]);
    $status_value.css('color', code_status_colors[$status_value.text()]);
    let $run_code_stdout = $('#run-code-stdout');
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
        let $run_code_time = $('#run-code-time');
        $run_code_time.show();
        $run_code_time.text("运行时间：" + data['time'] + "ms");
    }

    if (status !== 'Uploading' && status !== 'Pending' && status !== 'Running'){
        $('#run-code-status-loading-gif-id').hide();
        $('#submit_code_btn').removeClass('disabled');
        $('#run_code_btn').removeClass('disabled');
    }
};


$(document).ready(function () {

    $('#run-code-stdin').change(function () {
        if (IS_SET_EXPECTED_STDOUT) {
            $('#run-code-expected-stdout-block').hide();
            IS_SET_EXPECTED_STDOUT = false;
        }
    });

    $('#submit_code_btn').click(function () {

        if ($(this).hasClass('disabled')){
            return false;
        }
        $('#run_code_btn').addClass('disabled');
        $(this).addClass('disabled');

        $('#run-code-status-block').hide();
        $('#submit-code-status-block').show();
        $('#submit-code-status-compilation-log-id').hide();
        $('#submit-code-status-loading-gif-id').show();

        let $status_value = $('#submit-code-status-value-id');
        $status_value.text('Uploading');
        $status_value.css('color', code_status_colors[$status_value.text()]);

        chat_state.chat_socket.send(JSON.stringify({
            'activity': "problem_submit_code",
            'problem_id': PROBLEM_ID,
            'code': ace.edit("code_editor").getValue(),
            'language': $('.code_editor_option_language').children('select').children(':selected').text(),
        }));

        return false;
    });

    $('#run_code_btn').click(function () {

        if ($(this).hasClass('disabled')){
            return false;
        }
        $('#submit_code_btn').addClass('disabled');
        $(this).addClass('disabled');

        $('#submit-code-status-block').hide();
        let $run_code_status_block = $('#run-code-status-block');
        $run_code_status_block.css('margin-top', '75px');
        $run_code_status_block.show();
        $('#run-code-status-loading-gif-id').show();

        let $status_value = $('#run-code-status-value-id');
        if ($status_value.hasClass("submit-code-status-value-chinese")) {
            $status_value.removeClass("submit-code-status-value-chinese")
                .addClass("submit-code-status-value");
        }
        $status_value.text('Uploading');
        $status_value.css('color', code_status_colors[$status_value.text()]);
        $('#run-code-stdout').text('');
        $('#run-code-time').hide();

        chat_state.chat_socket.send(JSON.stringify({
            'activity': "problem_run_code",
            'problem_id': PROBLEM_ID,
            'code': ace.edit("code_editor").getValue(),
            'language': $('.code_editor_option_language').children('select').children(':selected').text(),
            'input': $('#run-code-stdin').val(),
        }));

        return false;
    });

    $('#run-code-status-block-remove-btn').click(function () {
        $('#run-code-status-block').hide();
        return false;
    });

    let $textarea = $('textarea.autofit');
    __initMeasurerFor($textarea);
    __updateTextAreaSize($textarea);

    $textarea.on({
        input: function(){
            let text = $(this).val();
            if($(this).attr("preventEnter") === undefined){
                text = text.replace(/[\n]/g, "<br>&#8203;");
            }
            __measurer.html(text);
            __updateTextAreaSize($(this));
        },
    });
});