<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>技术分享-515lab</title>
    <#include "../common/links-tpl.ftl" />
</head>
<body id="acwing_body">

<!-- 网页导航 -->
<#include "../common/navbar-tpl.ftl" />

<div class="base_body">

    <div class="container">
        <div class="panel panel-default">
            <div class="panel-body">

                <h1 class="text-center">515lab技术分享</h1>

                <br>
                <div class="row">
                    <div class="col-xs-12 col-sm-10 col-md-6 col-sm-offset-1 col-md-offset-3">
<#--                        <form id="form_search" action="/blog/search/1/" method="get">-->
<#--                            <input type='hidden' name='csrfmiddlewaretoken' value='TCRnFsGHNn9mmmcn8HC6buwSoYRjBHBSPtfXGqPn5fJCXBUtyfq6GlP1mctIOeV7'>-->
<#--                            <div class="input-group">-->
<#--                                <input type="text" name="search_content" class="form-control" placeholder="搜索作者、搜索标题、关键字、文章内容" style="border-radius: 5px;" maxlength="200">-->
<#--                                <span class="input-group-btn">-->
<#--                                <button class="btn btn-link" type="submit" style="border-radius: 5px;">-->
<#--                                    &nbsp;&nbsp;<span class="glyphicon glyphicon-search" style="font-size: 17px;"></span>-->
<#--                                </button>-->
<#--                              </span>-->
<#--                            </div>-->
<#--                        </form>-->
                    </div>
                </div>

                <div class="text-right">
                    <#if !logininfo??>
                        <a href="#"
                           class="btn btn-info btn-index btn-lg"
                           data-toggle="modal" data-target="#login-modal">
                            写分享&nbsp;
                            <span class="glyphicon glyphicon-pencil"></span>
                        </a>
                    <#else>
                    <a href="/addBlog.do?id=${logininfo.id}"
                       class="btn btn-info btn-index btn-lg">
                        写分享&nbsp;
                        <span class="glyphicon glyphicon-pencil"></span>
                    </a>
                    </#if>
                </div>

                <hr>
                <div class="table-responsive">
                    <table class="table table-striped table-responsive">
                        <thead>
                        <tr>
                            <th>标题</th>
                            <th>作者</th>
                            <th>时间</th>
                            <th>阅读</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list blogList as blog>
                            <tr>
                                <td>
                                    <a href="/content.do?id=${blog.id}">${blog.title}
                                        <#if blog.weight gt 10><span class="glyphicon glyphicon-arrow-up" style="color: rgb(192, 162, 100)"></span></#if>
                                        <#if blog.readSize gt 100><span class="glyphicon glyphicon-fire" style="color: red"></span></#if>
                                        <#if blog.blogType == 0><span class="glyphicon glyphicon-lock" style="color: darkgreen"></span></#if>
                                    </a>
                                </td>
                                <td>
                                    <a href="/userspace.do?id=${blog.author.id}">
                                        <img class="img-circle" src="${blog.author.avatar}" width="30px">
                                        &nbsp;
                                       ${blog.author.username}
                                    </a>
                                </td>
                                <td title="2019/09/16/ 18:29:06">${blog.createTime?string('yyyy-MM-dd hh:mm:ss')}</td>
                                <td>${blog.readSize}</td>
                            </tr>
                        </#list>

                        </tbody>
                    </table>
                </div>
<#--                <div align="right">-->
<#--                    <ul class="pagination">-->
<#--                        <li><a name="page_turning" id="page_1" href="">&laquo;</a></li>-->

<#--                        <li class="active">-->
<#--                            <a name="page_turning" id="page_1" href="1/Index.html">1</a>-->
<#--                        </li>-->

<#--                        <li class="">-->
<#--                            <a name="page_turning" id="page_2" href="2/Index.html">2</a>-->
<#--                        </li>-->

<#--                        <li class="">-->
<#--                            <a name="page_turning" id="page_3" href="3/Index.html">3</a>-->
<#--                        </li>-->

<#--                        <li class="">-->
<#--                            <a name="page_turning" id="page_4" href="4/Index.html">4</a>-->
<#--                        </li>-->

<#--                        <li class="">-->
<#--                            <a name="page_turning" id="page_5" href="5/Index.html">5</a>-->
<#--                        </li>-->

<#--                        <li><a name="page_turning" id="page_6" href="6/Index.html">&raquo;</a></li>-->
<#--                    </ul>-->
<#--                </div>-->
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