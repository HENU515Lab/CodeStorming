<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html">

<meta name="keywords" content="AcWing,Leetcode,题解,编程,算法">
<meta name="description" content="一个专属于程序员的平台，为大家在漫漫的刷题之旅中，提供最优质的解答">
<meta name="baidu-site-verification" content="UW1SBiMHO7">
<meta name="google-site-verification" content="YTgbOq_0TDShJS6KTcUYCQoAAZTm308SJ7ibsafBD_Y">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">


<link rel="stylesheet" href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<link rel="stylesheet" href="static/web/css/signform.css">
<link rel="stylesheet" href="static/jquery-ui-dist/jquery-ui.min.css">


<!--link rel="stylesheet" href="https://cdn.acwing.com/static/web/css/pace.css"-->
<!--script src="https://cdn.acwing.com/static/web/js/pace.js"></script-->
<script>
    let onbeforeunload_functions = [];
</script>
<script src="static/jquery/js/jquery-3.3.1.min.js"></script>
<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script src="static/jquery-ui-dist/jquery-ui.min.js"></script>
<script src="static/web/js/signform.js"></script>
<script src="static/web/js/handlebars-v1.3.0.js"></script>
<script src="static/web/js/effect_anchor.js"></script>

<script>
    let user_state = {
        is_authenticated: false,
        is_mobile: false,
    };
    if (user_state.is_authenticated) {
        user_state.user_id = None;
    }

</script>


<style>
    /* latin */
    @font-face {
        font-family: 'Satisfy';
        font-style: normal;
        font-weight: 400;
        src: local('Satisfy Regular'), local('Satisfy-Regular'), url(static/web/fonts/rP2Hp2yn6lkG50LoCZOIHQ.woff2) format('woff2');
        unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
    }

    /* latin-ext */
    @font-face {
        font-family: 'Lato';
        font-style: italic;
        font-weight: 400;
        src: local('Lato Italic'), local('Lato-Italic'), url(static/web/fonts/S6u8w4BMUTPHjxsAUi-qJCY.woff2) format('woff2');
        unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB, U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
    }

    /* latin */
    @font-face {
        font-family: 'Lato';
        font-style: italic;
        font-weight: 400;
        src: local('Lato Italic'), local('Lato-Italic'), url(static/web/fonts/S6u8w4BMUTPHjxsAXC-q.woff2) format('woff2');
        unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
    }

    /* latin-ext */
    @font-face {
        font-family: 'Lato';
        font-style: italic;
        font-weight: 700;
        src: local('Lato Bold Italic'), local('Lato-BoldItalic'), url(static/web/fonts/S6u_w4BMUTPHjxsI5wq_FQft1dw.woff2) format('woff2');
        unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB, U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
    }

    /* latin */
    @font-face {
        font-family: 'Lato';
        font-style: italic;
        font-weight: 700;
        src: local('Lato Bold Italic'), local('Lato-BoldItalic'), url(static/web/fonts/S6u_w4BMUTPHjxsI5wq_Gwft.woff2) format('woff2');
        unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
    }

    /* latin-ext */
    @font-face {
        font-family: 'Lato';
        font-style: normal;
        font-weight: 400;
        src: local('Lato Regular'), local('Lato-Regular'), url(static/web/fonts/S6uyw4BMUTPHjxAwXjeu.woff2) format('woff2');
        unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB, U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
    }

    /* latin */
    @font-face {
        font-family: 'Lato';
        font-style: normal;
        font-weight: 400;
        src: local('Lato Regular'), local('Lato-Regular'), url(static/web/fonts/S6uyw4BMUTPHjx4wXg.woff2) format('woff2');
        unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
    }

    /* latin-ext */
    @font-face {
        font-family: 'Lato';
        font-style: normal;
        font-weight: 700;
        src: local('Lato Bold'), local('Lato-Bold'), url(static/web/fonts/S6u9w4BMUTPHh6UVSwaPGR_p.woff2) format('woff2');
        unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB, U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
    }

    /* latin */
    @font-face {
        font-family: 'Lato';
        font-style: normal;
        font-weight: 700;
        src: local('Lato Bold'), local('Lato-Bold'), url(static/web/fonts/S6u9w4BMUTPHh6UVSwiPGQ.woff2) format('woff2');
        unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
    }
</style>
<style>
    #acwing_body {
        background: white url("static/web/img/background.png");
    }


</style>


<link rel="stylesheet" href="static/web/css/style-0.0.1.css">


<link rel="stylesheet" href="static/plugins/css/ace.min.css">
<link rel="stylesheet" href="static/plugins/css/semantic.min.css">
<link rel="stylesheet" href="static/plugins/css/resizable.min.css">
<link rel="stylesheet" href="static/martor/css/martor.min.css">

<link rel="stylesheet" href="static/web/css/martor.css">

<link rel="stylesheet" href="static/web/css/community/content.css">

<link rel="stylesheet" href="static/web/css/about/index-0.0.6.css">


<link href="static/web/third_party/videojs/video.js/dist/video-js.min.css" rel="stylesheet">
<link href="static/web/third_party/videojs/videojs-watermark/dist/videojs-watermark.css" rel="stylesheet">
<link rel="stylesheet" href="static/web/css/video/quality.css">
<link rel="stylesheet" href="static/web/css/video/playbackrate.css">
<link rel="stylesheet" href="static/web/css/video/webfullscreen.css">
<link rel="stylesheet" href="static/web/css/video/player.css">

<link rel="stylesheet" href="static/editor.md/css/editormd.min.css" />