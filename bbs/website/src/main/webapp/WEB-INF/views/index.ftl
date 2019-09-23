<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>515lab</title>
    <#include "common/links-tpl.ftl" />
</head>
<body id="acwing_body">

<!-- 网页导航 -->
<#include "common/navbar-tpl.ftl" />


<div class="base_body">


    <div class="container">
        <div class="row">
            <div id="file_display_field"
                 class="col-xs-offset-0 col-xs-12 col-sm-offset-2 col-sm-8 col-md-offset-2 col-md-8">

                <center><h1>展示页面待完成！</h1></center>

            </div>
        </div>
    </div>


    <div id="loading_file_gif" class="panel panel-default about-index-file-panel"
         style="background-color: #FFFFFF; display: none">
        <div class="panel-body about-index-file-panel-body">
            <div id="loading_gif">
                <img class="img-circle" src="static/web/gif/img_loading.gif" width="80px" alt="加载中" title="加载中"
                     style="display: block; margin: 0 auto;">
            </div>
        </div>
    </div>
    <div id="modal-danger" class="modal modal-message modal-danger fade" style="display: none;" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <i class="glyphicon glyphicon-fire"></i>
                </div>
                <div class="modal-body">你确定删除吗？</div>
                <div class="modal-footer">
                    <form id="modal_danger_delete_url" method="post" action="" enctype="multipart/form-data">
                        <input type='hidden' name='csrfmiddlewaretoken'
                               value='6fhkhcDEsbkXQxYGSo1yWF77cQz2NmPV26FUiaMkK3UdrMGMiWPyrwqga4br0T9a'>
                        <button type="button" class="btn" data-dismiss="modal">取消</button>
                        <button id="modal_danger_delete_url_btn" class="btn btn-danger" data-dismiss="modal"
                                type="submit">
                            删除
                        </button>
                    </form>
                </div>
            </div> <!-- / .modal-content -->
        </div> <!-- / .modal-dialog -->
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

<#include "common/footer-tpl.ftl" />
<#include "common/scripts-tpl.ftl" />
</body>
</html>