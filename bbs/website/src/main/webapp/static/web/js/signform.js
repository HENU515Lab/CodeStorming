$(function() {

    var $formLogin = $('#login-form');
    var $formLost = $('#lost-form');
    var $formRegister = $('#register-form');
    var $divForms = $('#div-forms');
    var $modalAnimateTime = 300;
    var $msgAnimateTime = 150;
    var $msgShowTime = 2000;
    var $refreshDelayTime = 500;
    var $lost_password_btn = $('#lost_password_btn');
    var $is_sending_email = false;

    $(".sign-form").submit(function () {
        var postData = $(this).serializeArray();
        var formUrl = $(this).attr("action");

        switch(this.id) {
            case "login-form":
                $.ajax({
                    url: formUrl,
                    type: "POST",
                    data: postData,
                    dataType: "json",
                    success: function(resp){
                        if (resp.error_message === "success"){
                            msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "success", "glyphicon-ok", "登录成功");
                            if (typeof redirect_to_index_url !== 'undefined'){
                                setTimeout("window.location.href = redirect_to_index_url", $refreshDelayTime);
                            }
                            else{
                                setTimeout("window.location.href = location.href;", $refreshDelayTime);
                            }
                        }
                        else{
                            msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "error", "glyphicon-remove", resp.error_message);
                        }
                    },
                    error: function(){
                        msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "error", "glyphicon-remove", "系统忙，请稍后重试");
                    }
                });
                break;
            case "lost-form":
                if ($is_sending_email){
                    break;
                }
                $.ajax({
                   url: formUrl,
                   type: "POST",
                   data: postData,
                   dataType: "Json",
                   success: function(resp){
                       if (resp.error_message === "success"){
                           msgChange2($('#div-lost-msg'), $('#icon-lost-msg'), $('#text-lost-msg'), "success", "glyphicon-ok", "发送成功");
                           setTimeout("window.location.href = location.href;", $refreshDelayTime);
                           /*$lost_password_btn.disabled = false;
                           $lost_password_btn.removeClass('disabled');
                           $is_sending_email = false;*/
                       }
                       else if(resp.error_message ===  "email not found") {
                           msgChange2($('#div-lost-msg'), $('#icon-lost-msg'), $('#text-lost-msg'), "error", "glyphicon-remove", "用户邮箱不存在");
                           $lost_password_btn.disabled = false;
                           $lost_password_btn.removeClass('disabled');
                           $is_sending_email = false;
                       }
                       else{
                           msgChange2($('#div-lost-msg'), $('#icon-lost-msg'), $('#text-lost-msg'), "error", "glyphicon-remove", "发送失败，请稍后重试");
                           $lost_password_btn.disabled = false;
                           $lost_password_btn.removeClass('disabled');
                           $is_sending_email = false;
                       }
                   },
                    error: function(){
                       msgChange2($('#div-lost-msg'), $('#icon-lost-msg'), $('#text-lost-msg'), "error", "glyphicon-remove", "发送失败，请稍后重试");
                       $lost_password_btn.disabled = false;
                       $lost_password_btn.removeClass('disabled');
                       $is_sending_email = false;
                    }
                });
                $is_sending_email = true;
                $lost_password_btn.disabled = true;
                $lost_password_btn.addClass('disabled');
                msgChange($('#div-lost-msg'), $('#icon-lost-msg'), $('#text-lost-msg'), "warning", "glyphicon-send", "正在发送 ...");
                break;
            case "register-form":
                $.ajax({
                   url: formUrl,
                   type: "POST",
                   data: postData,
                   dataType: "Json",
                   success: function(resp){
                       if (resp.error_message === "success"){
                           msgChange($('#div-register-msg'), $('#icon-register-msg'), $('#text-register-msg'), "success", "glyphicon-ok", "注册成功");
                           if (typeof redirect_to_index_url !== 'undefined'){
                                setTimeout("window.location.href = redirect_to_index_url", $refreshDelayTime);
                            }
                            else{
                                setTimeout("window.location.href = location.href;", $refreshDelayTime);
                            }
                       }
                       else{
                           msgChange($('#div-register-msg'), $('#icon-register-msg'), $('#text-register-msg'), "error", "glyphicon-remove", resp.error_message);
                       }
                   },
                    error: function(){
                       msgChange($('#div-register-msg'), $('#icon-register-msg'), $('#text-register-msg'), "error", "glyphicon-remove", "系统忙，请稍后重试");
                    }
                });
                break;
            default:
                break;
        }
        return false;
    });

    $('#login_register_btn').click( function () { modalAnimate($formLogin, $formRegister) });
    $('#register_login_btn').click( function () { modalAnimate($formRegister, $formLogin); });
    $('#login_lost_btn').click( function () { modalAnimate($formLogin, $formLost); });
    $('#lost_login_btn').click( function () { modalAnimate($formLost, $formLogin); });
    $('#lost_register_btn').click( function () { modalAnimate($formLost, $formRegister); });
    $('#register_lost_btn').click( function () { modalAnimate($formRegister, $formLost); });

    function modalAnimate ($oldForm, $newForm) {
        var $oldH = $oldForm.height();
        var $newH = $newForm.height();
        $divForms.css("height",$oldH);
        $oldForm.fadeToggle($modalAnimateTime, function(){
            $divForms.animate({height: $newH}, $modalAnimateTime, function(){
                $newForm.fadeToggle($modalAnimateTime);
            });
        });
    }

    function msgFade ($msgId, $msgText) {
        $msgId.fadeOut($msgAnimateTime, function() {
            $(this).text($msgText).fadeIn($msgAnimateTime);
        });
    }

    function msgChange($divTag, $iconTag, $textTag, $divClass, $iconClass, $msgText) {
        var $msgOld = $divTag.text();
        msgFade($textTag, $msgText);
        $divTag.addClass($divClass);
        $iconTag.removeClass("glyphicon-chevron-right");
        $iconTag.addClass($iconClass + " " + $divClass);
        if ($divClass !== 'warning'){
            setTimeout(function() {
                msgFade($textTag, $msgOld);
                $divTag.removeClass($divClass);
                $iconTag.addClass("glyphicon-chevron-right");
                $iconTag.removeClass($iconClass + " " + $divClass);
            }, $msgShowTime);
        }
    }

    function msgChange2($divTag, $iconTag, $textTag, $divClass, $iconClass, $msgText) {
        var $msgOld = $divTag.text();
        msgFade($textTag, $msgText);
        $divTag.addClass($divClass);
        $iconTag.removeClass("glyphicon-send");
        $iconTag.removeClass("warning");
        $divTag.removeClass("warning");
        $iconTag.addClass($iconClass + " " + $divClass);
        setTimeout(function() {
            msgFade($textTag, $msgOld);
            $divTag.removeClass($divClass);
            $iconTag.addClass("glyphicon-chevron-right");
            $iconTag.removeClass($iconClass + " " + $divClass);
        }, $msgShowTime);
    }
});