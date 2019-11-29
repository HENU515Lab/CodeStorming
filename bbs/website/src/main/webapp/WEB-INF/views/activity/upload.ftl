<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>活动-515lab</title>
    <#include "../common/links-tpl.ftl" />
</head>
<body id="acwing_body">

<!-- 网页导航 -->
<#include "../common/navbar-tpl.ftl" />


<div class="base_body">

    <div class="container">
        <div class="panel panel-default">
            <div class="panel-body">

                <div class="container-fluid">
                    <h2>${activityContent.title}</h2>
                    <p>${activityContent.activityContentAbstract}</p>
                    <form id="form" action="upload/insert" method="post" enctype="multipart/form-data">
                        <div class="row form-group">
                            <label class="col-md-4">文件上传:</label>
                            <div class="col-sm-12">
                                <input id="input-id" name="file" multiple type="file" data-show-caption="true">
                            </div>
                        </div>
                    </form>
                </div>

            </div>
        </div>

    </div>

</div>



<div id="modal-warning" class="modal modal-message modal-warning fade" style="display: none;" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <i class="glyphicon glyphicon-warning-sign"></i>
            </div>
            <div id="warning_message_content" class="modal-body"></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-warning" data-dismiss="modal">OK</button>
            </div>
        </div> <!-- / .modal-content -->
    </div> <!-- / .modal-dialog -->
</div>

<#include "../common/footer-tpl.ftl" />
<#include "../common/scripts-tpl.ftl" />

<script src="static/bootstrap-fileinput/js/fileinput.js"></script>
<script src="static/bootstrap-fileinput/js/locales/zh.js"></script>
<script src="static/bootstrap-fileinput/js/plugins/piexif.js"></script>
<script src="static/bootstrap-fileinput/js/plugins/purify.js"></script>
<script src="static/bootstrap-fileinput/js/plugins/sortable.js"></script>
<script src="static/bootstrap-fileinput/themes/fa/theme.min.js"></script>
<script>
    $(function () {
        initFileInput("input-id");
    })

    function initFileInput(ctrlName) {
        var control = $('#' + ctrlName);
        control.fileinput({
            language: 'zh', //设置语言
            uploadUrl: "/uploadActivityFile.do?id=" + ${activityContent.id},
            uploadAsync: false, //默认异步上传
            showUpload: true, //是否显示上传按钮
            showRemove : true, //显示移除按钮
            showPreview : true, //是否显示预览
            showCaption: false,//是否显示标题
            browseClass: "btn btn-primary", //按钮样式
            dropZoneEnabled: true,//是否显示拖拽区域
            maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
            minFileCount: 0,
            maxFileCount: 10, //表示允许同时上传的最大文件个数
            enctype: 'multipart/form-data',
            validateInitialCount:true,
            previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
            msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",

        }).on('filepreupload', function(event, data, previewId, index) {     //上传中
            var form = data.form, files = data.files, extra = data.extra,
                response = data.response, reader = data.reader;
            console.log('文件正在上传');
        }).on("fileuploaded", function (event, data, previewId, index) {    //一个文件上传成功
            var form = data.form, files = data.files, extra = data.extra,
                response = data.response, reader = data.reader;
            console.log(response)
        }).on('fileerror', function(event, data, msg) {  //一个文件上传失败
            var form = data.form, files = data.files, extra = data.extra,
                response = data.response, reader = data.reader;
        })
    }

</script>
</body>
</html>