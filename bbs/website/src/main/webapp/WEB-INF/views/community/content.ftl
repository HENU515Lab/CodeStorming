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
                                <#if !logininfo??>
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
                                <#else>
                                    <a id="vote_up_btn" onclick="$('#form_voteup').submit();"
                                       style="cursor: pointer;">
                                        <span class="glyphicon glyphicon-triangle-top vote form_voteup
                                            <#if voteOffset == 1> vote_active</#if>"></span></a>
                                    <br>
                                    <span class="votecnt">${community.voteSize}</span>
                                    <br>
                                    <a id="vote_down_btn" onclick="$('#form_votedown').submit();"
                                       style="cursor: pointer;">
                                        <span class="glyphicon glyphicon-triangle-bottom vote form_votedown
                                            <#if voteOffset == -1> vote_active</#if>"></span>
                                    </a>
                                    <br>
                                    <a href='#' ><span
                                                class="glyphicon glyphicon-star vote"></span></a>
                                    <br>
                                    <span class="favoritecnt"></span>
                                </#if>
                                <form id="form_voteup" class="form_vote" action="/communityVoteUp.do" method="post">
                                    <input type="hidden" name="communityId" value="${community.id}">
                                </form>
                                <form id="form_votedown" class="form_vote" action="/communityVoteDown.do" method="post">
                                    <input type="hidden" name="communityId" value="${community.id}">
                                </form>
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
                        <p class="nice_font answer_title">
                            ${community.answerSize}
                            个问答
                        </p>
                        <hr>
                        <#list community.answers as answer>
                            <div class="row answer_field" id="answer_666">
                                <div class="col-xs-1 vote_cut" align="center">

                                    <#if !logininfo??>
                                        <a href='#' data-toggle="modal" data-target="#login-modal"><span
                                                    class="glyphicon glyphicon-triangle-top vote "></span></a>
                                        <br>
                                        <span class="answer_votecnt">${answer.voteSize}</span>
                                        <br>
                                        <a href='#' data-toggle="modal" data-target="#login-modal">
                                            <span class="glyphicon glyphicon-triangle-bottom vote "></span>
                                        </a>
                                        <br>
                                        <#if answer.pass == 1>
                                            <span class="votecnt glyphicon glyphicon-ok form_answer_voteup_${answer.id}_ok
                                            form_answer_votedown_${answer.id}_ok " style="color: #5fba7d;"></span>
                                        </#if>
                                    <#else>
                                        <a id="answer_vote_up_btn" onclick="$('#answer_form_voteup_${answer.id}').submit();"
                                           style="cursor: pointer;">
                                        <span class="glyphicon glyphicon-triangle-top vote answer_form_voteup_${answer.id}
                                            <#if answer.voteOffset == 1> vote_active</#if>"></span></a>
                                        <br>
                                        <span class="answer_votecnt answer_votecnt_${answer.id}">${answer.voteSize}</span>
                                        <br>
                                        <a id="answer_vote_down_btn" onclick="$('#anser_form_votedown_${answer.id}').submit();"
                                           style="cursor: pointer;">
                                        <span class="glyphicon glyphicon-triangle-bottom vote answer_form_votedown_${answer.id}
                                            <#if answer.voteOffset == -1> vote_active</#if>"></span>
                                        </a>
                                        <br>
                                        <#if answer.pass == 1>
                                            <span class="votecnt glyphicon glyphicon-ok form_answer_voteup_${answer.id}_ok
                                            form_answer_votedown_${answer.id}_ok " style="color: #5fba7d;"></span>
                                        </#if>
                                        <form id="anser_form_votedown_${answer.id}" class="form_vote"
                                              action="/communityVoteDown.do" method="post">
                                            <input type="hidden" name="communityId" value="${community.id}">
                                            <input type="hidden" name="communityAnswerId" value="${answer.id}">
                                        </form>
                                    </#if>

                                </div>
                                <div class="col-xs-11 vote_cut">
                                    <div class="main-martor main-martor-content" data-field-name="content">
                                        <div class="section-martor">
                                            <div class="ui bottom attached tab active martor-preview"
                                                 data-tab="preview-tab-content">
                                                <div id="community-answer-${answer.id}" class="blog-content">
                                                    <textarea style="display:none;" name="test-editormd-markdown-doc">${answer.content}</textarea>
                                                </div>
                                                <div align="right">
                                                    <div align="left">
                                                        <#if !logininfo??>
                                                        <#else>
                                                            <#if community.asker.id == logininfo.id && answer.pass != 1>
                                                                <button class="pass_a_comment btn btn-link" title="满意这个回答？" data-toggle="modal" data-target="#modal-ok"
                                                                        onclick="setOkId('${answer.id}')">
                                                                    <span class="glyphicon glyphicon-ok"></span>
                                                                </button>
                                                            </#if>
                                                        </#if>

                                                    </div>
                                                    <div class="information_card" align="left">
                                                        <span class="datetime"
                                                              title="${answer.createTime?string('yyyy-MM-dd hh:mm:ss')}">
                                                            回答于${answer.createTime?string('yyyy-MM-dd hh:mm:ss')}
                                                        </span>
                                                        <div class="row">
                                                            <div class="col-xs-4" style="padding-right:0;">
                                                                <a href="/userspace.do?id=${answer.answerUser.id}">
                                                                    <img class="img photo"
                                                                         src="${answer.answerUser.avatar}"
                                                                         width="40px" height="40px">
                                                                </a>
                                                            </div>
                                                            <div class="col-xs-8" style="padding-left:0;">
                                                                <div style="height: 13px; line-height: 1;">
                                                                    <a href="/userspace.do?id=${answer.answerUser.id}">
                                                                        <span class="nice_font"
                                                                              title="${answer.answerUser.username}"
                                                                              style="font-size: 16px;">
                                                                            ${answer.answerUser.username}
                                                                        </span>
                                                                    </a>
                                                                </div>
                                                                <div style="height: 13px; margin-top: 8px;" title="声望值">
                                                                    <span class="glyphicon glyphicon-star"
                                                                          style="color: #f5d500; font-size: 14px;"></span>
                                                                    <span style="font-size: 14px; font-weight: bold; color: #6a737c">
                                                                        ${answer.answerUser.visitors}
                                                                    </span>
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
                                        <hr class="comment_hr">
                                        <#list answer.communityAnswerCommentList as answerComment>
                                            <div id="ac_${answer.id}_${answerComment.id}" class="subcomment">
                                                <span class="nice_font">
                                                    ${answerComment.content}&nbsp;–&nbsp;
                                                </span>
                                                <a href="/userspace.do?id=${answerComment.user.id}">
                                                    <span class="nice_font" style="font-size: 16px;">
                                                        ${answerComment.user.username}
                                                    </span>
                                                </a>
                                                &nbsp;
                                                <span class="datetime"
                                                      title="${answerComment.createTime?string('yyyy-MM-dd hh:mm:ss')}">
                                                    ${answerComment.createTime?string('yyyy-MM-dd hh:mm:ss')}
                                                </span>
                                            </div>
                                            <hr class="comment_hr">
                                        </#list>

                                        <#if !logininfo??>
                                            <button class="add_a_comment btn btn-link"
                                                    data-toggle="modal" data-target="#login-modal">
                                                发表评论
                                            </button>
                                        <#else>
                                            <button class="add_a_comment btn btn-link"
                                                    id="cs_${answer.id}_btn">
                                                发表评论
                                            </button>
                                            <div id="cs_${answer.id}_content" class="row" style="margin-top: 10px; display: none;">
                                                <div class="col-md-1 col-sm-2 col-xs-3" style="padding-right:5px;">
                                                    <a href="/userspace.do?id=${user.id}">
                                                        <img width="50px" src="${user.avatar}">
                                                    </a>
                                                </div>
                                                <div class="col-md-11 col-sm-10 col-xs-9" style="padding-left:5px;">
                                                    <form action="/addCommunityAnswerComment.do" class="form" method="post">
                                                        <textarea class="form-control" name="content" rows="2" maxlength="1000" required="" title="回复"></textarea>
                                                        <input type="hidden" name="communityId" value="${community.id}">
                                                        <input type="hidden" name="communityAnswerId" value="${answer.id}">
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
                            <hr>
                        </#list>

                        <div class="text-right">
                            <#if !logininfo??>
                                <a class="btn btn-default btn-subtitle" data-toggle="modal" data-target="#login-modal">
                                    我来回答
                                    <span class="glyphicon glyphicon-pencil"></span>
                                </a>
                            <#else>
                                <a href="/addAnswer.do?id=${community.id}" class="btn btn-default btn-subtitle">
                                    我来回答
                                    <span class="glyphicon glyphicon-pencil"></span>
                                </a>
                            </#if>
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
    <!-- Modal -->
    <div class="modal fade" id="modal-ok" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <i class="glyphicon glyphicon-ok-sign"></i>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    你确定同意这个答案吗？
                </div>
                <div class="modal-footer">
                    <form id="modal_ok_pass_url" method="post" action="/communityAnswerOk.do" enctype="multipart/form-data">
                        <input id="communityAnswerId" type="hidden" name="communityAnswerId" value="" />
                        <input type="hidden" name="communityId" value="${community.id}" />
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                        <button type="submit" class="btn btn-primary">确定</button>
                    </form>
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
    <#list community.answers as answer>
        communityAnswer${answer.id} =
            editormd.markdownToHTML("community-answer-${answer.id}", {
            htmlDecode      : "style,script,iframe",  // you can filter tags decode
            emoji           : true,
            taskList        : true,
            tex             : true,  // 默认不解析
            flowChart       : true,  // 默认不解析
            sequenceDiagram : true,  // 默认不解析
        });
    </#list>
</script>
<script>
    $(document).ready(function () {

        $('#qc_btn').click(function () {
            $('#qc_content').toggle(500);
        });

        <#list community.answers as answer>
            $('#cs_${answer.id}_btn').click(function () {
                $('#cs_${answer.id}_content').toggle(500);
            });
        </#list>
    });
</script>
</body>
</html>