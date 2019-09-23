<script src="static/web/js/copy_with_link.js"></script>
<script>
    let article_author = "AcWing";
    let VIDEO_CONTENT_WATERMARK_LOGO_URL = "https://cdn.acwing.com/static/web/img/32X32.ico";
    let ABOUT_VIDEOJS_OPTIONS = {
        autoplay: false,
        controls: true,
        controlBar: {
            currentTimeDisplay: true,
            timeDivider: true,
            durationDisplay: true,
            remainingTimeDisplay: false,
            volumePanel: {
                inline: false,
                vertical: true
            }
        },
        preload: 'metadata',
    };
    let GLOBAL_FILE_COUNT = 10;
    let GLOBAL_PULL_FILES_URL = "/about/pull_files/5642/666/";
    let GLOBAL_COMMENT_SONS = {};


</script>
<script>

    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);//search,查询？后面的参数，并匹配正则
        if (r != null) return decodeURIComponent(r[2]);
        return null;
    }

    $(function () {
        var myurl = GetQueryString("error_message");
        if (myurl != null && myurl.toString().length > 1) {
            setTimeout(function () {
                $.bootstrapGrowl(myurl, {
                    type: 'danger',
                    align: 'right',
                    width: 'auto',
                    allow_dismiss: false
                });
            }, 0);
        }
    });
</script>
<script src="static/plugins/js/highlight.min.js"></script>
<script type="text/x-mathjax-config">
            MathJax.Hub.Config({
              tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]},
              showMathMenu: false
            });


</script>
<script type="text/javascript" src="static/MathJax-2.6-latest/MathJax-TeX-AMS-MML_HTMLorMML.js"></script>
<script src="static/web/third_party/videojs/video.js/dist/video.min.js"></script>
<script src="static/web/third_party/videojs/videojs-flash/dist/videojs-flash.min.js"></script>
<script>videojs.options.flash.swf = "https://cdn.acwing.com/static/web/third_party/videojs/videojs-swf/dist/video-js.swf"</script>
<script src="static/web/third_party/videojs/videojs-watermark/dist/videojs-watermark.min.js"></script>

<script src="static/web/js/video/quality.js"></script>
<script src="static/web/js/video/playbackrate.js"></script>
<script src="static/web/js/video/webfullscreen-0.0.1.js"></script>
<script src="static/web/js/video/player-0.0.2.js"></script>

<script src="static/web/js/file_system/file/content/abstract/vote-0.0.1.js"></script>
<script src="static/web/js/file_system/file/content/abstract/collect-0.0.2.js"></script>
<script src="static/web/js/about/pull_files-0.0.9.js"></script>
<script type="text/javascript" src="static/web/js/file_system/file/operation/comment/add-0.0.4.js"></script>
<script type="text/javascript" src="static/web/js/file_system/file/operation/comment/delete-0.0.3.js"></script>
<script type="text/javascript" src="static/web/js/upload_profileinfo.js"></script>
<script type="text/javascript" src="static/web/js/uploadphoto.js"></script>
<script type="text/javascript" src="static/web/node_modules/cropper/dist/cropper.js"></script>
<script type="text/javascript" src="static/web/node_modules/imagesloaded/imagesloaded.pkgd.min.js"></script>
<script type="text/javascript" src="static/web/js/canvas-toBlob.js"></script>
<script type="text/javascript" src="static/web/js/jquery.bootstrap-growl.min.js"></script>


<script>

    $(document).ready(function () {
        let $weixin_connect_link = $('#third_party_weixin_connect_link_base');
        $weixin_connect_link.attr("href", "/third_party/weixin/open_platform/login/apply_code/?source_url=/");
        if (typeof WeixinJSBridge === "object" && typeof WeixinJSBridge.invoke === "function") {
            callback();
        } else {
            if (document.addEventListener) {
                document.addEventListener("WeixinJSBridgeReady", callback, false);
            } else if (document.attachEvent) {
                document.attachEvent("WeixinJSBridgeReady", callback);
                document.attachEvent("onWeixinJSBridgeReady", callback);
            }
        }

        function callback() {
            $weixin_connect_link.attr("href", "/third_party/weixin/open_platform/login/apply_code/1/?source_url=/");
        }
    });

    window.onbeforeunload = function (ev) {
        let notify = false;
        for (let i = 0; i < onbeforeunload_functions.length; i++) {
            let ret = onbeforeunload_functions[i]();
            if (ret) {
                notify = true;
            }
        }
        if (notify) {
            return true;
        }
    };

    let CLICK_URL_STATUS = "status";
    let CLICK_URL_COUNT = "count";
    let CLICK_URL_CLICK = "click";
    let CLICK_URL = "/" + CLICK_URL_STATUS + "/" + CLICK_URL_COUNT + "/" + CLICK_URL_CLICK + "/";
</script>
<script src="static/web/js/status/click.js"></script>
