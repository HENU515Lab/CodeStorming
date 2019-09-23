<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>个人设置-515lab</title>
    <#include "../common/links-tpl.ftl" />
</head>
<body id="acwing_body">

<!-- 网页导航 -->
<#include "../common/navbar-tpl.ftl" />

<div class="base_body">

    <div class="container">
        <div class="row text-center">
            <div class="col-md-3 col-sm-5 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-body">

                        <h3>修改密码</h3>

                        <hr>
                        <form class="form-horizontal" role="form" action="/changepassword.do" method="post" enctype="multipart/form-data">

                            <div class="form-group">
                                <label class="sr-only" for="id_currentpassword">新密码</label>
                                <input type="password" name="currentpassword" required="" placeholder="当前密码" id="id_currentpassword" maxlength="16">
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="id_newpassword1">新密码</label>
                                <input type="password" name="newpassword1" required="" placeholder="新密码" id="id_newpassword1" maxlength="16">
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="id_newpassword2">确认密码</label>
                                <input type="password" name="newpassword2" required="" placeholder="确认密码" id="id_newpassword2" maxlength="16">
                            </div>
                            <hr>
                            <div class="form-group">
                                <button class="btn btn-default btn-primary" type="submit">修改密码</button>
                            </div>
                            <#if error_message??>
                                <p style="font-size: 15px; color:red"><strong>${error_message}</strong></p>
                            </#if>
                            <#if success_message??>
                                <p style="font-size: 15px; color:green"><strong>${success_message}</strong></p>
                            </#if>
                        </form>
                    </div>
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
</body>
</html>