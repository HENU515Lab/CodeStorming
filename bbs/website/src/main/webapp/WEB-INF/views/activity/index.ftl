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

                <h1 class="text-center">515lab 活动</h1>

                <#list activityList.list as activity>

                    <#if .now?date gt activity.startTime?date
                    && activity.endTime?date gt .now?date>
                    <#--        活动中            -->
                        <hr style="margin: 30px 0 1px 0;">

                        <div class="activity-index-block">
                            <div class="row">
                                <div class="hidden-sm hidden-xs col-md-1" style="max-width: 100px;">
                                    <img src="${activity.surface}" width="80px" alt="活动封面">
                                </div>
                                <div class="col-xs-sm col-md-11">
                                    <a href="/activityDetail.do?id=${activity.id}">
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-8">
                                                <span class="activity_title">${activity.title}</span>
                                            </div>
                                            <div class="col-xs-12 col-sm-4" align="right">
                                                <span class="btn btn-success activity_status">进行中</span>
                                            </div>
                                            <div class="col-xs-12 col-sm-6">
                                                <div class="visible-xs-block">
                                                    <hr>
                                                </div>
                                                <span class="activity_abstract">${activity.activityAbstract}</span>
                                            </div>
                                            <div class="col-xs-12 col-sm-6 text-center">
                                                <div class="visible-xs-block">
                                                    <hr>
                                                </div>
                                                <div class="col-xs-4">
                                                    <span class="activity_th">参与人数</span>
                                                    <br>
                                                    <span class="activity_td">${activity.joinNum}</span>
                                                </div>
                                                <div class="col-xs-8">
                                                    <span class="activity_th">起止时间</span>
                                                    <br>

                                                    <span class="activity_td">
                                                    ${activity.startTime?string('MM-dd')}
                                                    ~
                                                    ${activity.endTime?string('MM-dd')}
                                                </span>

                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                    <#else>
                    <#--        活动结束            -->
                        <hr style="margin: 30px 0 1px 0;">

                        <div class="activity-index-block">
                            <div class="row">
                                <div class="hidden-sm hidden-xs col-md-1" style="max-width: 100px;">
                                    <img src="${activity.surface}" width="80px" alt="活动封面">
                                </div>
                                <div class="col-xs-sm col-md-11">
                                    <a href="">
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-8">
                                                <span class="activity_title">${activity.title}</span>
                                            </div>
                                            <div class="col-xs-12 col-sm-4" align="right">
                                                <span class="btn btn-info activity_status disabled">已结束</span>
                                            </div>
                                            <div class="col-xs-12 col-sm-6">
                                                <div class="visible-xs-block">
                                                    <hr>
                                                </div>
                                                <span class="activity_abstract">${activity.activityAbstract}</span>
                                            </div>
                                            <div class="col-xs-12 col-sm-6 text-center">
                                                <div class="visible-xs-block">
                                                    <hr>
                                                </div>
                                                <div class="col-xs-4">
                                                    <span class="activity_th">参与人数</span>
                                                    <br>
                                                    <span class="activity_td">${activity.joinNum}</span>
                                                </div>
                                                <div class="col-xs-8">
                                                    <span class="activity_th">起止时间</span>
                                                    <br>

                                                    <span class="activity_td">
                                                        ${activity.startTime?string('YY-MM-dd')}
                                                        ~
                                                        ${activity.endTime?string('YY-MM-dd')}
                                                    </span>

                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </#if>
                </#list>

                <div align="right">
                    <ul class="pagination">
                        <li><a name="page_turning" id="page_${1}"
                               href="/activity.do?pageNum=${1}">&laquo;</a></li>
                        <#if activityList.pages gt 4 && activityList.pageNum gt 4>
                            <#list activityList.navigatepageNums as num>
                                <#if (num - activityList.pageNum > -4 && num - activityList.pageNum <= 1)
                                || (activityList.hasNextPage == false && num - activityList.pageNum > -5)>
                                    <li <#if num == activityList.pageNum>class="active"</#if>>
                                        <a name="page_turning" id="page_${num}" href="/activity.do?pageNum=${num}">
                                            ${num}
                                        </a>
                                    </li>
                                </#if>
                            </#list>
                        <#else>
                            <#list activityList.navigatepageNums as num>
                                <#if num <= 5>
                                    <li <#if num == activityList.pageNum>class="active"</#if>>
                                        <a name="page_turning" id="page_${num}" href="/activity.do?pageNum=${num}">
                                            ${num}
                                        </a>
                                    </li>
                                </#if>
                            </#list>
                        </#if>
                        <li><a name="page_turning" id="page_${activityList.pageSize}"
                               href="/activity.do?pageNum=${activityList.pages}">&raquo;</a></li>
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