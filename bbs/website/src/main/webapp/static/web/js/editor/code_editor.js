$(document).ready(function () {

    let code_editor = ace.edit("code_editor");

    let save_code = function () {
        if (typeof(localStorage) !== "undefined") {
            let $problem_id = PROBLEM_ID;
            let $user_id = "anonymous";
            if (user_state.is_authenticated){
                $user_id = user_state.user_id;
            }
            let $language = $('.code_editor_option_language').children('select').children(':selected').text();

            let filename = $problem_id + '-' + $user_id + '-' + $language;
            localStorage.setItem(filename, code_editor.getValue());
        }
    };

    let refresh_code = function () {
        let $language = $('.code_editor_option_language').children('select').children(':selected').text();
        if ($language in problem_code_show_mappings){
            code_editor.setValue(problem_code_show_mappings[$language], -1);
        }
        else {
            code_editor.setValue('', -1);
        }
    };

    let load_code = function () {
        let has_set_value = false;
        if (typeof(localStorage) !== "undefined") {
            code_editor.setValue('', -1);
            let $problem_id = PROBLEM_ID;
            let $user_id = "anonymous";
            if (user_state.is_authenticated){
                $user_id = user_state.user_id;
            }
            let $language = $('.code_editor_option_language').children('select').children(':selected').text();

            let filename = $problem_id + '-' + $user_id + '-' + $language;
            let code = localStorage.getItem(filename);

            if (typeof code === "string" && code.length > 0){
                code_editor.setValue(code, -1);
                has_set_value = true;
            }
            else if ($user_id !== "anonymous"){
                let filename = $problem_id + '-anonymous-' + $language;
                code = localStorage.getItem(filename);
                if (typeof code === "string" && code.length > 0){
                    code_editor.setValue(code, -1);
                    has_set_value = true;
                }
            }
        }
        if (!has_set_value) {
            refresh_code();
        }
    };

    let update_language = function () {
        let language = $('.code_editor_option_language').children('select').children(':selected').text();
        let language_mapping = code_editor_name_config_mappings[language];
        code_editor.session.setMode("ace/mode/" + language_mapping);
    };

    let update_theme = function () {
        let theme = $('.code_editor_option_theme').first().children('select').children(':selected').text();
        let theme_mapping = code_editor_name_config_mappings[theme];
        code_editor.setTheme("ace/theme/" + theme_mapping);
    };

    let update_key_binding = function () {
        let key_binding = $('.code_editor_option_key_binding').first().children('select').children(':selected').text();
        let key_binding_mapping = code_editor_name_config_mappings[key_binding];
        if (key_binding_mapping === "null"){
            code_editor.setKeyboardHandler(null);
        }
        else{
            code_editor.setKeyboardHandler('ace/keyboard/' + key_binding_mapping);
        }
    };

    let update_tab_size = function () {
        let tab_size = $('.code_editor_option_tab_size').first().children('select').children(':selected').text();
        let tab_size_mapping = code_editor_name_config_mappings[tab_size];
        code_editor.setOption("tabSize", parseInt(tab_size_mapping));
    };

    let code_editor_init = function(){
        code_editor.setShowPrintMargin(false);
        update_language();
        update_theme();
        update_key_binding();
        update_tab_size();
        code_editor.setOptions({
            fontSize: "11pt",
            maxLines: Infinity,
            enableBasicAutocompletion: false,
            enableSnippets: false,
            enableLiveAutocompletion: false
        });
    };

    code_editor_init();

    let $code_editor_option_language = $('.code_editor_option_language');

    $code_editor_option_language.click(function () {
        save_code();
    });

    $('#code-editor-refresh-btn').click(function () {
        refresh_code();
    });

    $code_editor_option_language.children('select').change(function () {
        let language = $(this).children(':selected').text();
        let language_mapping = code_editor_name_config_mappings[language];
        code_editor.session.setMode("ace/mode/" + language_mapping);
        load_code();
        if (user_state.is_authenticated) {
            let $form = $('#code-eidtor-option-update-language-form');
            let hrefUrl = $form.attr('action');
            let postData = $form.serialize() + "&name=" + encodeURIComponent(language);
            $.ajax({
                url: hrefUrl,
                type: "POST",
                data: postData,
                dataType: "Json",
                cache: false,
                timeout: 60000,
                success: function (resp) {

                },
                error: function () {
                }
            });
        }
    });

    $('.code_editor_option_theme').children('select').change(function () {
        let theme = $(this).children(':selected').text();
        let theme_mapping = code_editor_name_config_mappings[theme];
        code_editor.setTheme("ace/theme/" + theme_mapping);

        if (user_state.is_authenticated) {
            let $form = $('#code-eidtor-option-update-theme-form');
            let hrefUrl = $form.attr('action');
            let postData = $form.serialize() + "&name=" + encodeURIComponent(theme);
            $.ajax({
                url: hrefUrl,
                type: "POST",
                data: postData,
                dataType: "Json",
                cache: false,
                timeout: 60000,
                success: function (resp) {

                },
                error: function () {
                }
            });
        }
    });

    $('.code_editor_option_key_binding').children('select').change(function () {
        let key_binding = $(this).children(':selected').text();
        let key_binding_mapping = code_editor_name_config_mappings[key_binding];
        if (key_binding_mapping === "null"){
            code_editor.setKeyboardHandler(null);
        }
        else{
            code_editor.setKeyboardHandler('ace/keyboard/' + key_binding_mapping);
        }

        if (user_state.is_authenticated) {
            let $form = $('#code-eidtor-option-update-key-binding-form');
            let hrefUrl = $form.attr('action');
            let postData = $form.serialize() + "&name=" + encodeURIComponent(key_binding);
            $.ajax({
                url: hrefUrl,
                type: "POST",
                data: postData,
                dataType: "Json",
                cache: false,
                timeout: 60000,
                success: function (resp) {

                },
                error: function () {
                }
            });
        }
    });

    $('.code_editor_option_tab_size').children('select').change(function () {
        let tab_size = $(this).children(':selected').text();
        let tab_size_mapping = code_editor_name_config_mappings[tab_size];
        code_editor.setOption("tabSize", parseInt(tab_size_mapping));

        if (user_state.is_authenticated) {
            let $form = $('#code-eidtor-option-update-tab-size-form');
            let hrefUrl = $form.attr('action');
            let postData = $form.serialize() + "&name=" + encodeURIComponent(tab_size);
            $.ajax({
                url: hrefUrl,
                type: "POST",
                data: postData,
                dataType: "Json",
                cache: false,
                timeout: 60000,
                success: function (resp) {

                },
                error: function () {
                }
            });
        }
    });

    load_code();

    onbeforeunload_functions.push(function () {
        save_code();
        return false;
    });
});