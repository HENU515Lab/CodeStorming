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

                <h1 class="text-center">515lab 应用中心</h1>

                <hr style="margin: 30px 0 1px 0;">
                <div class="row">

                    <div class="col-xs-4 col-sm-4">
                        <a href="/training.do" style="text-decoration: none;">
                            <div class="panel">
                                <div class="panel-body" style="padding: 0; margin-top: 10px;">
                                    <img src="https://i.loli.net/2019/11/21/jxqputfK4IrBVwg.jpg" alt="码不停题的图标" width="100%">
                                </div>
                                <div class="panel-footer text-center" style="background-color: white; ">

                                    <span style="font-size: 24px; font-weight: 500; color: #3c4043; line-height: 2.5rem;">码不停题</span>
                                    <br>
<#--                                    <span style="font-size: 12px; color: #3c4043;">浏览：1587</span>-->

                                </div>
                            </div>
                        </a>

                    </div>



                </div>
                <div align="right">
                    <ul class="pagination">
                        <li><a href="">&laquo;</a></li>

                        <li class="active"><a href="">1</a></li>

                        <li><a href="">&raquo;</a></li>
                    </ul>
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