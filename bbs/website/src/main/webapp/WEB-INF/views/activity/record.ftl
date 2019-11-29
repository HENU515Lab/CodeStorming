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
        <div class="panel panel-default copy-with-link">
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-12">
                        <span class="activity_title nice_font">${activity.title}</span>
                        &nbsp;&nbsp;&nbsp;
                        <span class="btn btn-success activity_status">进行中</span>
                        <!--

                        -->

                    </div>
                    <div class="col-xs-12">
                        &nbsp;
                    </div>
                    <div class="col-xs-6">
                        <span class="activity_th">参与人数：${activity.joinNum}</span>
                        &nbsp;&nbsp;&nbsp;&nbsp;

                        <span class="activity_th">
                            起止时间：
                            ${activity.startTime?string('MM-dd')}
                            ~
                            ${activity.endTime?string('MM-dd')}
                        </span>

                    </div>
                    <div class="col-xs-6 text-right">

                        <#if !logininfo??>
                        <#-- 未登录 -->
                            <a href="#" class="btn btn-info btn-lg btn-index" data-toggle="modal"
                               data-target="#login-modal">
                                报名
                            </a>
                        <#else>
                        <#-- 已登录 -->
                            <#if apply == 0>
                                <a href="/activityApply.do?id=${activity.id}" class="btn btn-info btn-lg btn-index">
                                    报名
                                </a>
                            <#else>
                                <a href="#" class="btn btn-info btn-lg btn-index">
                                    已报名
                                </a>
                            </#if>
                        </#if>
                    </div>
                </div>
                <br>
                <ul class="nav nav-tabs nav-justified activity-sub-btn">
                    <li role="presentation" class="">
                        <a href="/activityDetail.do?id=${activity.id}">详情</a>
                    </li>

                    <#if !logininfo??>
                        <li role="presentation" class="" data-toggle="modal" data-target="#login-modal">
                            <a href="#">内容</a>
                        </li>
                    <#else>
                        <li role="presentation" class="">
                            <a href="/activityContent.do?id=${activity.id}">内容</a>
                        </li>
                    </#if>

                    <li role="presentation" class="active">
                        <a href="/activityRecord.do?id=${activity.id}">动态</a>
                    </li>
                    <#--                    <li role="presentation" class="">-->
                    <#--                        <a href="/activityDiscuss.do?id=${activity.id}">贴吧</a>-->
                    <#--                    </li>-->
                </ul>
                <br>

                <#list activityContentRecordList.list as record>
                    <div class="row">
                        <div class="col-xs-2 col-sm-1">
                            <a href="/userspace.do?id=${record.user.id}">
                                <img class="img-circle" src="${record.user.avatar}" width="40">
                            </a>
                        </div>
                        <div class="col-xs-10 col-sm-11">
                            <div style="height: 18px; line-height: 1;">
                    <span class="nice_font" style="font-size: 16px;">
                        <a href="/userspace.do?id=${record.user.id}">${record.user.username}</a>
                        已完成
                    </span>
                            </div>
                            <div style="min-height: 15px; margin-top: 8px;">
                                <#if logininfo?? && logininfo.userType == 0>
                                    <a href="${record.filePath}">
                                        <span style="font-size: 15px; font-weight: bold;">
                                        ${record.activityContent.title}
                                        </span>
                                    </a>
                                <#else>
                                    <a href="#">
                                        <span style="font-size: 15px; font-weight: bold;">
                                        ${record.activityContent.title}
                                        </span>
                                    </a>
                                </#if>
                            </div>


                            <span class="datetime" style="float: right;">
                    上传于 ${record.createTime?string('MM-dd hh:mm:ss')}
                </span>
                        </div>
                    </div>
                    <hr>
                </#list>
                <div align="right">
                    <ul class="pagination">
                        <li><a name="page_turning" id="page_${1}"
                               href="/activityRecord.do?id=${activity.id}&pageNum=${1}">&laquo;</a></li>
                        <#if activityContentRecordList.pages gt 4 && activityContentRecordList.pageNum gt 4>
                            <#list activityContentRecordList.navigatepageNums as num>
                                <#if (num - activityContentRecordList.pageNum > -4 && num - activityContentRecordList.pageNum <= 1)
                                || (activityContentRecordList.hasNextPage == false && num - activityContentRecordList.pageNum > -5)>
                                    <li <#if num == activityContentRecordList.pageNum>class="active"</#if>>
                                        <a name="page_turning" id="page_${num}"
                                           href="/activityRecord.do?id=${activity.id}&pageNum=${num}">
                                            ${num}
                                        </a>
                                    </li>
                                </#if>
                            </#list>
                        <#else>
                            <#list activityContentRecordList.navigatepageNums as num>
                                <#if num <= 5>
                                    <li <#if num == activityContentRecordList.pageNum>class="active"</#if>>
                                        <a name="page_turning" id="page_${num}"
                                           href="/activityRecord.do?id=${activity.id}&pageNum=${num}">
                                            ${num}
                                        </a>
                                    </li>
                                </#if>
                            </#list>
                        </#if>
                        <li><a name="page_turning" id="page_${activityContentRecordList.pageSize}"
                               href="/activityRecord.do?id=${activity.id}&pageNum=${activityContentRecordList.pages}">&raquo;</a></li>
                    </ul>
                </div>

            </div>
        </div>

        <div>

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
    testEditormdView2 = editormd.markdownToHTML("test-editormd-view", {
        htmlDecode: "style,script,iframe",  // you can filter tags decode
        emoji: true,
        taskList: true,
        tex: true,  // 默认不解析
        flowChart: true,  // 默认不解析
        sequenceDiagram: true,  // 默认不解析
    });
</script>
</body>
</html>