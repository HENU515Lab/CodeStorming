<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>error-515lab</title>
    <#include "../common/links-tpl.ftl" />
    <style>
        .content {
            float: none;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
    </style>
</head>
<body id="acwing_body">

<!-- 网页导航 -->
<#include "../common/navbar-tpl.ftl" />


<div class="base_body">

    <div class="container">
        <div class="row text-center">
            <h1>很抱歉，只有实验室成员才能访问这篇文章！</h1>
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