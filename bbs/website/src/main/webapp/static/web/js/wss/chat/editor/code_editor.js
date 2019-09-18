$(document).ready(function () {

    let code_editor = ace.edit("chat_code_editor");
    let $code_editor_option_language = $('.chat_code_editor_option_language');
    chat_state.code_editor = code_editor;
    chat_state.editor_language = $code_editor_option_language.children('select').children(':selected').text();

    let save_code = function () {
        if (typeof(localStorage) !== "undefined") {
            let $host_id = chat_state.now_host_id;
            let $user_id = "anonymous";
            if (user_state.is_authenticated){
                $user_id = user_state.user_id;
            }
            let $language = $('.chat_code_editor_option_language').children('select').children(':selected').text();

            let filename = 'chat-editor-' + $host_id + '-' + $user_id + '-' + $language;
            localStorage.setItem(filename, code_editor.getValue());
        }
    };
    chat_state.editor_save_code = save_code;

    let refresh_code = function () {
        let $language = $('.chat_code_editor_option_language').children('select').children(':selected').text();
        code_editor.setValue('', -1);
    };

    let load_code = function () {
        let has_set_value = false;
        if (typeof(localStorage) !== "undefined") {
            code_editor.setValue('', -1);
            let $host_id = chat_state.now_host_id;
            let $user_id = "anonymous";
            if (user_state.is_authenticated){
                $user_id = user_state.user_id;
            }
            let $language = $('.chat_code_editor_option_language').children('select').children(':selected').text();

            let filename = 'chat-editor-' + $host_id + '-' + $user_id + '-' + $language;
            let code = localStorage.getItem(filename);

            if (typeof code === "string" && code.length > 0){
                code_editor.setValue(code, -1);
                has_set_value = true;
            }
            else if ($user_id !== "anonymous"){
                let filename = 'chat-editor-' + $host_id + '-anonymous-' + $language;
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
        let language = $('.chat_code_editor_option_language').children('select').children(':selected').text();
        let language_mapping = chat_code_editor_name_config_mappings[language];
        code_editor.session.setMode("ace/mode/" + language_mapping);
    };

    let update_theme = function () {
        let theme = $('.chat_code_editor_option_theme').first().children('select').children(':selected').text();
        let theme_mapping = chat_code_editor_name_config_mappings[theme];
        code_editor.setTheme("ace/theme/" + theme_mapping);
    };

    let update_key_binding = function () {
        let key_binding = $('.chat_code_editor_option_key_binding').first().children('select').children(':selected').text();
        let key_binding_mapping = chat_code_editor_name_config_mappings[key_binding];
        if (key_binding_mapping === "null"){
            code_editor.setKeyboardHandler(null);
        }
        else{
            code_editor.setKeyboardHandler('ace/keyboard/' + key_binding_mapping);
        }
    };

    let update_tab_size = function () {
        let tab_size = $('.chat_code_editor_option_tab_size').first().children('select').children(':selected').text();
        let tab_size_mapping = chat_code_editor_name_config_mappings[tab_size];
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

    $code_editor_option_language.click(function () {
        if (chat_state.editor_type === 2) return;
        save_code();
    });

    $('#chat_code-editor-refresh-btn').click(function () {
        refresh_code();
    });

    $code_editor_option_language.children('select').change(function () {

        if (chat_state.editor_type === 2) return;

        let language = $(this).children(':selected').text();
        chat_state.editor_language = language;
        let language_mapping = chat_code_editor_name_config_mappings[language];
        code_editor.session.setMode("ace/mode/" + language_mapping);
        load_code();
        if (user_state.is_authenticated) {
            let $form = $('#chat_code-eidtor-option-update-language-form');
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

    $('.chat_code_editor_option_theme').children('select').change(function () {
        let theme = $(this).children(':selected').text();
        let theme_mapping = chat_code_editor_name_config_mappings[theme];
        code_editor.setTheme("ace/theme/" + theme_mapping);

        if (user_state.is_authenticated) {
            let $form = $('#chat_code-eidtor-option-update-theme-form');
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

    $('.chat_code_editor_option_key_binding').children('select').change(function () {
        let key_binding = $(this).children(':selected').text();
        let key_binding_mapping = chat_code_editor_name_config_mappings[key_binding];
        if (key_binding_mapping === "null"){
            code_editor.setKeyboardHandler(null);
        }
        else{
            code_editor.setKeyboardHandler('ace/keyboard/' + key_binding_mapping);
        }

        if (user_state.is_authenticated) {
            let $form = $('#chat_code-eidtor-option-update-key-binding-form');
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

    $('.chat_code_editor_option_tab_size').children('select').change(function () {
        let tab_size = $(this).children(':selected').text();
        let tab_size_mapping = chat_code_editor_name_config_mappings[tab_size];
        code_editor.setOption("tabSize", parseInt(tab_size_mapping));

        if (user_state.is_authenticated) {
            let $form = $('#chat_code-eidtor-option-update-tab-size-form');
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

    $('#chat-code-editor-plugin-body').on( 'mousewheel DOMMouseScroll', function ( e ) {
        let e0 = e.originalEvent, delta = e0.wheelDelta || -e0.detail;
        this.scrollTop += ( delta < 0 ? 1 : -1 ) * 60;
        e.preventDefault();
    });

    let restore_editor = function(){
        let language = chat_state.editor_language;
        $('.chat_code_editor_option_language').children('select').children().filter(function() {
            return this.text === language;
        }).prop('selected', true);
        let language_mapping = chat_code_editor_name_config_mappings[language];
        code_editor.session.setMode("ace/mode/" + language_mapping);
        load_code();
    };

    $('.message_code_btn').click(function () {

        chat_state.editor_open_from = $(this).attr('name');
        chat_state.editor_type = 1;
        restore_editor();

        let $code_editor_plugin = $('#chat-code-editor-plugin');
        $code_editor_plugin.show();

        return false;
    });

    onbeforeunload_functions.push(function () {
        if (chat_state.editor_type === 2) return;
        save_code();
        return false;
    });
});