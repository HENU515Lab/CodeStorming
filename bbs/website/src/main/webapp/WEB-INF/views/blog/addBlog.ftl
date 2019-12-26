<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>新建文章-515lab</title>
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

                        <img class="img-responsive center-block" src="${user.avatar}">

                        <hr>
                        <div class="caption">
                            <p class="personal-info text-center">${logininfo.username}</p>
                            <p class="personal-info text-center">${user.grade}</p>
                        </div>
                        <hr>
                        <p class="personal-info text-center" style="font-size:100%;">
                            <strong>访客：${user.visitors}</strong>
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


                            <li class="nav pull-right active" role="presentation">
                                <a href="/addBlog.do?${logininfo.id}" class="user-myspace-base-subtitle">
                                    写分享&nbsp;
                                    <span class="glyphicon glyphicon-pencil"></span>
                                </a>
                            </li>
<#--my-->

                        </ul>
                        <br>


                        <form id="add_a_solution_form" method="post" action="/submitBlog.do" enctype="multipart/form-data">
                            <div class="row ui form">
                                <div class="col-xs-8">
                                    <#if !blog??>
                                        <input type="text" name="title" placeholder="标题" maxlength="200" id="id_title">
                                    <#else>
                                        <input type="text" name="title" value="${blog.title}" maxlength="200" id="id_title">
                                    </#if>

                                </div>
                                <div class="col-xs-4">
                                    <input type="text" name="keywords" placeholder="关键字（逗号分隔）" maxlength="50" id="id_keywords">
                                </div>

                            </div>
                            <div class="row">
                                <div class="col-xs-12">

                                    <div id="editor">
                                        <#if !blog??>
                                            <textarea name="content" style="display:none;">### 请写下你的分享或见解</textarea>
                                        <#else>
                                            <textarea name="content" style="display:none;">${blog.content}</textarea>
                                            <input type="hidden" name="id" value="${blog.id}" />
                                        </#if>

                                    </div>

                                </div>
<#--                                <div class="col-md-offset-8 col-md-2 col-sm-offset-6 col-sm-3 col-xs-offset-2 col-xs-5">-->
<#--                                    <button id="save_solution_btn" class="form-control btn btn-success" style="border-radius: 5px">保存</button>-->
<#--                                </div>-->
                                <div class="col-md-2 col-sm-3 col-xs-5">
                                    <button id="submit_solution_btn" class="form-control btn btn-success" style="border-radius: 5px">提交</button>
                                </div>
                                <#if error_message??>
                                    <div>${error_message}</div>
                                </#if>
                            </div>
                        </form>


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

<script src="static/editor.md/editormd.min.js"></script>
<script type="text/javascript">
    $(function() {
        var editor = editormd("editor", {
            width: "100%",
            height: "400",
            syncScrolling : "single",
            tex: true,// 开启科学公式TeX语言支持，默认关闭
            emoji: true,//emoji表情，默认关闭
            path : "static/editor.md/lib/",
            toolbarIcons : function() {
                return ["undo", "redo", "|", "bold", "hr", "||", "watch", "preview"]
            }
        });
    });
</script>
</body>
</html>