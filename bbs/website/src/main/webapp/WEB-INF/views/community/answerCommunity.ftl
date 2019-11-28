<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>问答-515lab</title>
    <#include "../common/links-tpl.ftl" />
</head>
<body id="acwing_body">

<!-- 网页导航 -->
<#include "../common/navbar-tpl.ftl" />


<div class="base_body">

    <div class="container">
        <div class="row">
            <div class="col-xs-offset-0 col-xs-12 col-sm-offset-2 col-sm-8 col-md-offset-2 col-md-9">

                <div class="panel panel-default copy-with-link">
                    <div class="panel-body">

                        <h2 class="nice_font" style="font-weight: normal;">
                            ${community.title}
                        </h2>
                        <div align="right">

                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-xs-1 vote_cut" align="center">

                                <a href='#' data-toggle="modal" data-target="#login-modal"><span
                                            class="glyphicon glyphicon-triangle-top vote "></span></a>
                                <br>
                                <span class="votecnt">${community.voteSize}</span>
                                <br>
                                <a href='#' data-toggle="modal" data-target="#login-modal">
                                    <span class="glyphicon glyphicon-triangle-bottom vote "></span>
                                </a>
                                <br>
                                <a href='#' data-toggle="modal" data-target="#login-modal"><span
                                            class="glyphicon glyphicon-star vote"></span></a>
                                <br>
                                <span class="favoritecnt"></span>

                            </div>
                            <div class="col-xs-11 vote_cut">
                                <div class="main-martor main-martor-content" data-field-name="content">
                                    <div class="section-martor">
                                        <div class="ui bottom attached tab active martor-preview">
                                            <div id="community-question" class="blog-content">
                                                <textarea style="display:none;" name="test-editormd-markdown-doc">${community.content}</textarea>
                                            </div>
                                            <span class="label label-default community_question_keywords"></span>
                                            <br><br>
                                            <div align="right">
                                                <div class="information_card" align="left">
                                                    <span class="datetime"
                                                          title="${community.createTime?string('yyyy-MM-dd hh:mm:ss')}">
                                                        提问于${community.createTime?string('yyyy-MM-dd hh:mm:ss')}
                                                    </span>
                                                    <div class="row">
                                                        <div class="col-xs-4" style="padding-right:0;">
                                                            <a href="/userspace.do?id=${community.asker.id}">
                                                                <img class="img photo" src="${community.asker.avatar}"
                                                                     width="40px" height="40px">
                                                            </a>
                                                        </div>
                                                        <div class="col-xs-8" style="padding-left:0;">
                                                            <div style="height: 13px; line-height: 1;">
                                                                <a href="/userspace.do?id=${community.asker.id}">
                                                                <span class="nice_font" title="${community.asker.username}"
                                                                      style="font-size: 16px;">
                                                                    ${community.asker.username}
                                                                </span>
                                                                </a>
                                                            </div>
                                                            <div style="height: 13px; margin-top: 8px;" title="声望值">
                                                                <span class="glyphicon glyphicon-star"
                                                                      style="color: #f5d500; font-size: 14px;"></span>
                                                                <span style="font-size: 14px; font-weight: bold; color: #6a737c">${community.asker.visitors}</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div><!-- end  /.section-martor -->
                                </div>
                            </div>

                            <div class="col-xs-offset-1 col-xs-11">
                                <div class="comment_field">
                                    <#list community.communityCommentList as comment>
                                        <div id="cs_${comment.id}" class="subcomment">
                                                <span class="nice_font">
                                                    ${comment.content}&nbsp;–&nbsp;
                                                </span>
                                            <a href="/userspace.do?id=${comment.user.id}">
                                                    <span class="nice_font" style="font-size: 16px;">
                                                        ${comment.user.username}
                                                    </span>
                                            </a>
                                            &nbsp;
                                            <span class="datetime"
                                                  title="${comment.createTime?string('yyyy-MM-dd hh:mm:ss')}">
                                                    ${comment.createTime?string('yyyy-MM-dd hh:mm:ss')}
                                                </span>
                                        </div>
                                        <hr class="comment_hr">
                                    </#list>
                                    <#if !logininfo??>
                                        <button class="add_a_comment btn btn-link" title="询问更详细的信息或提供建议，请不要在这里回答问题"
                                                data-toggle="modal" data-target="#login-modal">
                                            发表评论
                                        </button>
                                    <#else>
                                        <button class="add_a_comment btn btn-link" title="询问更详细的信息或提供建议，请不要在这里回答问题"
                                                id="qc_btn" >
                                            发表评论
                                        </button>
                                        <div id="qc_content" class="row" style="margin-top: 10px; display: none;">
                                            <div class="col-md-1 col-sm-2 col-xs-3" style="padding-right:5px;">
                                                <a href="/userspace.do?id=${user.id}">
                                                    <img width="50px" src="${user.avatar}">
                                                </a>
                                            </div>
                                            <div class="col-md-11 col-sm-10 col-xs-9" style="padding-left:5px;">
                                                <form id="question_comment_add_form" action="/addCommunityComment.do" class="form" method="post">
                                                    <textarea class="form-control" name="content" rows="2" maxlength="1000" required="" title="回复"></textarea>
                                                    <input type="hidden" name="communityId" value="${community.id}">
                                                    <div class="col-md-offset-10 col-md-2 col-sm-offset-9 col-sm-3 col-xs-offset-7 col-xs-5">
                                                        <button class="form-control btn btn-link" style="border-radius: 5px">提交评论</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </#if>

                                </div>
                            </div>
                        </div>
                        <br><br>
                        <p class="nice_font answer_title" id="write_my_answer_anchor" style="">
                            我来回答
                        </p>
                        <hr>
                        <form id="add_a_solution_form" method="post" action="/community/answer/content/add/655/11146/" enctype="multipart/form-data">
                            <input type="hidden" name="csrfmiddlewaretoken" value="rPEANW6CMqvqSik4v4yxhlWet8mYvnIOI4sbBgIJgNYQLy22dgdRejzy3Mssc224">
                            <div class="row">
                                <div class="col-xs-12">
                                    <div id="editor">
                                        <textarea name="content" style="display:none;">### 请写下你的分享或见解</textarea>
                                    </div>
                                </div>
<#--                                <div class="col-md-offset-8 col-md-2 col-sm-offset-6 col-sm-3 col-xs-offset-2 col-xs-5">-->
<#--                                    <button id="save_solution_btn" class="form-control btn btn-success" style="border-radius: 5px">保存</button>-->
<#--                                </div>-->
                                <div class="col-md-2 col-sm-3 col-xs-5">
                                    <button id="submit_solution_btn" class="form-control btn btn-success" style="border-radius: 5px">提交</button>
                                </div>
                            </div>
                        </form>

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
                <div class="modal-footer">
                    <form id="modal_danger_delete_url" method="post" action="" enctype="multipart/form-data">
                        <input type='hidden' name='csrfmiddlewaretoken'
                               value='WgZu8Z9D8dZre5AzwmxdMqc3YgMukONfoE5VhGNizcaF2BEPJVQyi7N8cCuwQccn'>
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
    communityQuestion = editormd.markdownToHTML("community-question", {
        htmlDecode      : "style,script,iframe",  // you can filter tags decode
        emoji           : true,
        taskList        : true,
        tex             : true,  // 默认不解析
        flowChart       : true,  // 默认不解析
        sequenceDiagram : true,  // 默认不解析
    });

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
</script>
<script>
    $(document).ready(function () {

        $('#qc_btn').click(function () {
            $('#qc_content').toggle(500);
        });
    });
</script>
</body>
</html>