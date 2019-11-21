<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>码不停题-515lab</title>
    <#include "../common/links-tpl.ftl" />
</head>
<body id="acwing_body">

<!-- 网页导航 -->
<#include "../common/navbar-tpl.ftl" />


<div class="base_body">

    <div class="container">
        <div class="panel panel-default">
            <div class="panel-body">

                <h2 style="margin-top: 10px;">码不停题</h2>


                <ul class="nav nav-tabs nav-justified activity-sub-btn">
                    <li role="presentation" class="active">
                        <a href="/application-intro.do">详情</a>
                    </li>
                    <li role="presentation" class="">
                        <a href="/training.do">训练</a>
                    </li>
                    <li role="presentation" class="">
                        <a href="javascript:;">排名</a>
                    </li>
                </ul>

                <br>

                <div class="main-martor main-martor-content" data-field-name="content">
                    <div class="section-martor">
                        <div class="ui bottom attached tab active martor-preview" data-tab="preview-tab-content">
                            <h3>515 刷题指南</h3>
                            <p>刷题经常被卡住，很可能是因为某个知识点或者思路的欠缺。</p>
                            <p>因此我们由易到难整理出题目之间的递进关系，为正在学习算法、准备竞赛的同学推荐平滑的刷题路线。</p>
                            <h4>功能介绍</h4>
                            <p>以知识图谱的形式展示所有题目。</p>
                            <ul>
                                <li>点表示题目，鼠标悬浮后会显示此题所有需要的先修题目。蓝色点表示起点，黄色点表示待解锁的题目，绿色点表示已通过的题目。</li>
                                <li>边表示题目之间的关系，鼠标悬浮后，会提示二者的转化关系。</li>
                            </ul>
                            <p>点进已解锁的题目后，会进入题目的挑战模式：在规定时间内编写并AC即可通过该题，否则失败，需要重新挑战。<br>
                                挑战模式中会禁用粘贴功能。<br>
                                学习算法时需要注重两个方面的能力：思维和代码熟练度，挑战模式旨在给大家提供一个自我检测熟练度的功能，在规定之间内AC即表示已经达到了相当的熟练度。</p>
                        </div>
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