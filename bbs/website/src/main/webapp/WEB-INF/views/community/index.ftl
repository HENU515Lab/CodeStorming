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
        <div class="row">
            <div id="file_display_field"
                 class="col-xs-offset-0 col-xs-12 col-sm-offset-2 col-sm-8 col-md-offset-2 col-md-8">

                <center><h1>问答功能待完成！正在熬夜开发ing</h1></center>

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
</body>
</html>