<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>用户空间-515lab</title>
    <#include "../common/links-tpl.ftl" />
</head>
<body id="acwing_body">

<!-- 网页导航 -->
<#include "../common/navbar-tpl.ftl" />


<div class="base_body">


    <div class="container">
        <div class="row">


            <div class="col-sm-4 col-md-3">
                <div class="panel panel-default">
                    <div class="panel-body" align="center">

                        <img class="img-responsive center-block" src="${userspace.avatar}">

                        <hr>
                        <div class="caption">
                            <p class="personal-info text-center">${userspace.username}</p>
                            <p class="personal-info text-center">${userspace.grade}</p>
                        </div>
                        <hr>
                        <p class="personal-info text-center" style="font-size:100%;">
                            <strong>访客：${userspace.visitors}</strong>
                        </p>

<#--                        <label class="btn btn-success text-center" style="border-radius: 5px;" data-toggle="modal" data-target="#login-modal">-->
<#--                            发消息-->
<#--                        </label>-->

                    </div>
                </div>
            </div>


            <div class="col-sm-8 col-md-9">

                <div class="panel panel-default">
                    <div class="panel-body">
                        <ul class="nav nav-tabs" style="font-size: 17px;">
                            <li role="presentation" class="active">
                                <a href="javascript:;" class="user-myspace-base-subtitle">分享</a>
                            </li>
<#--                            <li role="presentation" class="">-->
<#--                                <a href="javascript:;" class="user-myspace-base-subtitle">视频</a>-->
<#--                            </li>-->
                            <li role="presentation" class="">
                                <a href="javascript:;" class="user-myspace-base-subtitle">问答</a>
                            </li>
                            <li role="presentation" class="">
                                <a href="javascript:;" class="user-myspace-base-subtitle">活动</a>
                            </li>

<#--                            my-->
<#--                            <li role="presentation" class="">-->
<#--                                <a href="" class="dropdown-toggle user-myspace-base-subtitle" data-toggle="dropdown">-->
<#--                                    收藏-->
<#--                                    <b class="caret"></b>-->
<#--                                </a>-->
<#--                                <ul class="dropdown-menu">-->
<#--                                    <li><a href="javascript:;">题解</a></li>-->
<#--                                    <li><a href="javascript:;">分享</a></li>-->
<#--                                    <li><a href="javascript:;">问答</a></li>-->
<#--                                    <li><a href="javascript:;">代码</a></li>-->
<#--                                </ul>-->
<#--                            </li>-->
<#--                            <li role="presentation" class="">-->
<#--                                <a href="../../notification/1/Index.html" class="user-myspace-base-subtitle">通知</a>-->

<#--                            </li>-->

                                <#if !logininfo??>
                                    <li class="nav pull-right" role="presentation" data-toggle="modal" data-target="#login-modal">
                                        <a href="#" class="user-myspace-base-subtitle">
                                            写分享&nbsp;
                                            <span class="glyphicon glyphicon-pencil"></span>
                                        </a>
                                    </li>
                                <#else >
                                    <li class="nav pull-right" role="presentation" >
                                        <a href="/addBlog.do?id=${userspace.id}" class="user-myspace-base-subtitle">
                                            写分享&nbsp;
                                            <span class="glyphicon glyphicon-pencil"></span>
                                        </a>
                                    </li>
                                </#if>

<#--my-->

                        </ul>
                        <br>


                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>标题</th>
                                <th>日期</th>
                                <th>阅读</th>
                            </tr>
                            </thead>
                            <tbody>
                            <#list blogList as blog>
                                <tr>
                                    <td><a href="/content.do?id=${blog.id}">${blog.title}</a></td>
                                    <td>${blog.createTime?string('yyyy-MM-dd hh:mm:ss')}</td>
                                    <td>${blog.readSize}</td>
                                </tr>
                            </#list>

                            </tbody>
                        </table>

<#--                        <div align="right">-->
<#--                            <ul class="pagination">-->
<#--                                <li><a href="javascript:;">&laquo;</a></li>-->

<#--                                <li class="active"><a href="javascript:;">1</a></li>-->

<#--                                <li class=""><a href="javascript:;">2</a></li>-->

<#--                                <li class=""><a href="javascript:;">3</a></li>-->

<#--                                <li class=""><a href="javascript:;">4</a></li>-->

<#--                                <li class=""><a href="javascript:;">5</a></li>-->

<#--                                <li><a href="javascript:;">&raquo;</a></li>-->
<#--                            </ul>-->
<#--                        </div>-->
                        <div id="modal-danger" class="modal modal-message modal-danger fade" style="display: none;" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <i class="glyphicon glyphicon-fire"></i>
                                    </div>
                                    <div class="modal-body">你确定删除吗？</div>
                                    <div class="modal-footer">
                                        <form id="modal_danger_delete_url" method="post" action="" enctype="multipart/form-data">
                                            <input type='hidden' name='csrfmiddlewaretoken' value='qCrBmzPkxn2RvOwxA6yhhbkkFXbVXxBYmtPbnxY0PfC763eD0EmhM2DtDbNka4Vd'>
                                            <button type="button" class="btn" data-dismiss="modal">取消</button>
                                            <button id="modal_danger_delete_url_btn" class="btn btn-danger" data-dismiss="modal" type="submit">
                                                删除
                                            </button>
                                        </form>
                                    </div>
                                </div> <!-- / .modal-content -->
                            </div> <!-- / .modal-dialog -->
                        </div>

                    </div>
                </div>
            </div>
        </div></div>

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