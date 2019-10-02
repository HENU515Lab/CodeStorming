<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>AcWing</title>
    <#include "../common/links-tpl.ftl" />
</head>
<body id="acwing_body">

<!-- 网页导航 -->
<#include "../common/navbar-tpl.ftl" />


<div class="base_body">

    <div class="container">
        <div class="panel panel-default copy-with-link">
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-12">
                        <span class="activity_title nice_font">${activity.title}</span>
                        &nbsp;&nbsp;&nbsp;
                        <span class="btn btn-success activity_status">进行中</span>
                        <!--

                        -->

                    </div>
                    <div class="col-xs-12">
                        &nbsp;
                    </div>
                    <div class="col-xs-6">
                        <span class="activity_th">参与人数：${activity.joinNum}</span>
                        &nbsp;&nbsp;&nbsp;&nbsp;

                        <span class="activity_th">
                            起止时间：
                            ${activity.startTime?string('MM-dd')}
                            ~
                            ${activity.endTime?string('MM-dd')}
                        </span>

                    </div>
                    <div class="col-xs-6 text-right">

                        <a href="#" class="btn btn-info btn-lg btn-index" data-toggle="modal" data-target="#login-modal">
                            报名
                        </a>

                    </div>
                </div>
                <br>
                <ul class="nav nav-tabs nav-justified activity-sub-btn">
                    <li role="presentation" class="active">
                        <a href="">详情</a>
                    </li>

                    <li role="presentation" class="">
                        <a href="/activityContent.do?id=${activity.id}">内容</a>
                    </li>
                    <li role="presentation" class="">
                        <a href="/activityRecord.do?id=${activity.id}">动态</a>
                    </li>
                    <li role="presentation" class="">
                        <a href="/activityDiscuss.do?id=${activity.id}">贴吧</a>
                    </li>
                </ul>
                <br>

                <div class="main-martor main-martor-content" data-field-name="content">
                    <div class="section-martor">
                        <div id="test-editormd-view" class="ui bottom attached tab active martor-preview" data-tab="preview-tab-content">
                            <textarea style="display:none;" name="test-editormd-markdown-doc">${activity.detail}</textarea>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <div>

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
<script src="static/editor.md/lib/marked.min.js"></script>
<script src="static/editor.md/lib/prettify.min.js"></script>
<script src="static/editor.md/lib/raphael.min.js"></script>
<script src="static/editor.md/lib/underscore.min.js"></script>
<script src="static/editor.md/lib/sequence-diagram.min.js"></script>
<script src="static/editor.md/lib/flowchart.min.js"></script>
<script src="static/editor.md/lib/jquery.flowchart.min.js"></script>
<script src="static/editor.md/editormd.min.js"></script>
<script type="text/javascript">
    testEditormdView2 = editormd.markdownToHTML("test-editormd-view", {
        htmlDecode      : "style,script,iframe",  // you can filter tags decode
        emoji           : true,
        taskList        : true,
        tex             : true,  // 默认不解析
        flowChart       : true,  // 默认不解析
        sequenceDiagram : true,  // 默认不解析
    });
</script>
</body>
</html>