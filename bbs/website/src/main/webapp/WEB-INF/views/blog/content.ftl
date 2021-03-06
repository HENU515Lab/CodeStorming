<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>${blog.title}-515lab</title>
    <#include "../common/links-tpl.ftl" />
    <style>
        .blog-content {
            font-size: 18px;
        }
    </style>
</head>
<body id="acwing_body">

<!-- 网页导航 -->
<#include "../common/navbar-tpl.ftl" />

<div class="base_body">

    <div id="file-content-whole-field-full-5522" class="player-web-full-screen" style="display: none"></div>
    <div id="file-content-whole-field-5522">

        <div class="container">
            <div class="row">
                <div class="col-xs-offset-0 col-xs-12 col-sm-offset-2 col-sm-8 col-md-offset-2 col-md-9">

                    <div class="panel panel-default copy-with-link">
                        <div class="panel-body">

                            <h2>
                                ${blog.title}

                            </h2>

                            <div style="color: #999999; font-size:14px;">
                                作者：
                                <a href="/userspace.do?id=${blog.author.id}">
                                    <img class="img-circle" src="${blog.author.avatar}" width="30px" alt="作者的头像">
                                    &nbsp;
                                    <span style="font-size: 18px;">${blog.author.username}</span>
                                </a>
                                ,&nbsp;
                                ${blog.createTime?string('yyyy-MM-dd hh:mm:ss')}
                                ,&nbsp;
                                阅读&nbsp;${blog.readSize}
                            </div>

                            <div class="visible-xs">
                                <br>
                            </div>

                            <#if logininfo?? && logininfo.id == blog.author.id>
                                <div align="right">
                                    <a id="file_update_btn" class="btn btn-link" href="/addBlog.do?id=${blog.id}">
                                        <span class="glyphicon glyphicon-pencil" style="font-size: 20px;" title="编辑这个分享"></span>
                                    </a>
                                </div>
                            </#if>

                            <hr style="margin-bottom: 10px;">
                            <div class="row">
                                <div class="vote_cut col-xs-1" align="center">

                                    <#if !logininfo??>
                                        <a href='' data-toggle="modal" data-target="#login-modal"><span class="glyphicon glyphicon-triangle-top vote"></span></a>
                                        <br>
                                        <span class="votecnt">${blog.voteSize}</span>
                                        <br>
                                        <a href='' data-toggle="modal" data-target="#login-modal">
                                            <span class="glyphicon glyphicon-triangle-bottom vote"></span>
                                        </a>
                                        <br>
                                        <a href='' data-toggle="modal" data-target="#login-modal"><span class="glyphicon glyphicon-star vote"></span></a>
                                        <br>
                                    <#else >
                                        <a id="vote_up_btn" onclick="$('#form_voteup').submit();"
                                           style="cursor: pointer;">
                                            <span class="glyphicon glyphicon-triangle-top vote form_voteup
                                                <#if voteOffset == 1> vote_active</#if>"></span>
                                        </a>
                                        <br>
                                        <span class="votecnt">${blog.voteSize}</span>
                                        <br>
                                        <a id="vote_down_btn" onclick="$('#form_votedown').submit();"
                                           style="cursor: pointer;">
                                            <span class="glyphicon glyphicon-triangle-bottom vote form_votedown
                                                <#if voteOffset == -1> vote_active</#if>"></span>
                                        </a>
                                        <br>
                                        <a href=''><span class="glyphicon glyphicon-star vote"></span></a>
                                        <br>
                                    </#if>

                                    <form id="form_voteup" class="form_vote" action="/blogVoteUp.do" method="post">
                                        <input type="hidden" name="blogId" value="${blog.id}">
                                    </form>
                                    <form id="form_votedown" class="form_vote" action="/blogVoteDown.do" method="post">
                                        <input type="hidden" name="blogId" value="${blog.id}">
                                    </form>
<#--                                    <span class="favoritecnt">-->

<#--            2-->

    </span>

                                </div>
                                <div class="col-xs-11 vote_cut">
                                    <div id="test-editormd-view" class="blog-content">
                                        <textarea style="display:none;" name="test-editormd-markdown-doc">${blog.content}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="col-xs-offset-0 col-xs-12 col-sm-offset-2 col-sm-8 col-md-offset-2 col-md-9">

                    <div class="panel panel-default copy-with-link">
                        <div class="panel-body">



                            <h3 style="font-weight: normal;">评论列表：</h3>
                            <div class="row">
                                <#if !logininfo??>
                                    <div class="col-md-1 col-sm-2 col-xs-3">

                                    </div>
                                    <div class="col-xs-12">
                                        <form class="ui form" role="form" enctype="multipart/form-data" >
                                            <div data-toggle="modal" data-target="#login-modal" >
                    <textarea name="content" cols="40" rows="2" placeholder="在这里写评论..." maxlength="10000" required="" id="id_content">
</textarea>
                                            </div>
                                        </form>
                                        <div class="col-md-offset-10 col-md-2 col-sm-offset-9 col-sm-3 col-xs-offset-7 col-xs-5">
                                            <button class="form-control btn btn-link" style="border-radius: 5px" data-toggle="modal" data-target="#login-modal">
                                                提交评论
                                            </button>
                                        </div>
                                    </div>
                                <#else >
                                    <div class="col-md-1 col-sm-2 col-xs-3">

                                        <a href="/userspace.do?id=${user.id}">
                                            <img class="img-circle" src="${user.avatar}" width="45px" alt="我的头像">
                                        </a>

                                    </div>

                                    <div class="col-md-11 col-sm-10 col-xs-9">
                                        <form class="ui form comment_reply_form" role="form" method="post" action="/submitBlogComment.do" enctype="multipart/form-data">
                                            <textarea name="content" cols="40" rows="2" placeholder="在这里写评论..." maxlength="10000" required="" id="id_comment_content"></textarea>
                                            <div class="col-md-offset-10 col-md-2 col-sm-offset-9 col-sm-3 col-xs-offset-7 col-xs-5">
                                                <button class="form-control btn btn-link" style="border-radius: 5px">
                                                    提交评论
                                                </button>
                                            </div>
                                            <input type="hidden" name="blogId" value="${blog.id}">
                                        </form>
                                    </div>
                                </#if>


                            </div>
                            <div>
                                <#list blog.comments as comment>
                                    <div id="${comment.id}" style="padding-left: 0px;">

                                        <hr style="margin: 10px 0 10px 0;">

                                        <div class="row">
                                            <div class="col-md-1 col-sm-2 col-xs-3" style="max-width: 60px;">
                                                <a href="/userspace.do?id=${comment.user.id}">
                                                    <img class="img-circle" src="${comment.user.avatar}" alt="用户头像" width="45px">
                                                </a>
                                            </div>
                                            <div class="col-md-11 col-sm-10 col-xs-9">
                                                <div>
                                                    <a href="/userspace.do?id=${comment.user.id}" style="font-size: 15px;">${comment.user.username}</a>
                                                    &nbsp;
                                                    <span class="comment-title" title="2019-09-12 22:42">${comment.createTime?string('yyyy-MM-dd hh:mm:ss')}</span>

                                                    &nbsp;&nbsp;&nbsp;

<#--                                                    <a id="comment_reply_btn_4524" class="comment-title hand-cursor" data-toggle="modal" data-target="#login-modal">回复</a>-->
                                                    <#if logininfo?? && logininfo.id == comment.user.id>
                                                        <a id="comment_remove_${comment.id}" class="pull-right comment-title"
                                                           href="#"
                                                           data-toggle="modal" data-target="#modal-danger"
                                                           onclick="setDeleteUrl('${comment.id}')">
                                                            <span class="glyphicon glyphicon-trash"></span>
                                                        </a>
                                                    </#if>

                                                </div>
                                                <div>
                                                    <p>${comment.commentContent}</p>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </#list>
                            </div>
                        </div>
                    </div>
                </div>

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
                <div id="remove-modal-form" class="modal-footer">
<#--                    <form id="modal_danger_delete_url" method="post" action="" enctype="multipart/form-data">-->
<#--                        <button type="button" class="btn" data-dismiss="modal">取消</button>-->
<#--                        <button id="modal_danger_delete_url_btn" class="btn btn-danger" data-dismiss="modal" type="submit">-->
<#--                            删除-->
<#--                        </button>-->
<#--                    </form>-->
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

<#include "../common/footer-tpl.ftl" />
<#include "../common/scripts-tpl.ftl" />
<#--<script src="https://cdn.bootcss.com/jquery/2.2.3/jquery.min.js"></script>-->
<script src="static/editor.md/lib/marked.min.js"></script>
<script src="static/editor.md/lib/prettify.min.js"></script>
<script src="static/editor.md/lib/raphael.min.js"></script>
<script src="static/editor.md/lib/underscore.min.js"></script>
<script src="static/editor.md/lib/sequence-diagram.min.js"></script>
<script src="static/editor.md/lib/flowchart.min.js"></script>
<script src="static/editor.md/lib/jquery.flowchart.min.js"></script>
<script src="static/editor.md/editormd.min.js"></script>
<!-- toastr -->
<script src="static/web/third_party/toastr/toastr.min.js"></script>
<script type="text/javascript">
    testEditormdView2 = editormd.markdownToHTML("test-editormd-view", {
        htmlDecode      : "style,script,iframe",  // you can filter tags decode
        emoji           : true,
        taskList        : true,
        tex             : true,  // 默认不解析
        flowChart       : true,  // 默认不解析
        sequenceDiagram : true,  // 默认不解析
    });

    function setDeleteUrl(id) {
        var form_content = '<form id="modal_danger_delete_url" >\n' +
            '    <input type="hidden" name="id" value="' + id + '" />' +
            '    <button type="button" class="btn" data-dismiss="modal">取消</button>\n' +
            '    <button onclick="blogCommentItemRemove()" ' +
            'id="modal_danger_delete_url_btn" class="btn btn-danger" data-dismiss="modal" type="button">\n' +
            '        删除\n' +
            '    </button>\n' +
            '</form>'
        $('#remove-modal-form').html(form_content)
    }

    function blogCommentItemRemove() {
        $('#modal_danger_delete_url_btn').addClass('disabled')
        let hrefUrl = '/blogCommentItemDelete.do'
        let postData = $('#modal_danger_delete_url').serializeArray();
        $.ajax({
            url: hrefUrl,
            type: "POST",
            data: postData,
            dataType: "Json",
            cache: false,
            timeout: 60000,
            success: function (resp) {
                toastr.success('评论删除成功')
                setTimeout("location.href = '" + '/content.do?id=${blog.id}' + "'", 1000)
            },
            error: function () {
                toastr.fail('评论删除失败')
            }
        })
    }
</script>
</body>
</html>