<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>AcWing</title>
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
                    <div class="panel-body">
                        <div class="my_head_photo_container"><img id="my_head_photo" class="img-responsive center-block" src="../../../media/user/profile/photo/2462_lg_ca091bc249.jpg" style="display: none;"></div>
                        <img id="my_head_photo_loading" class="img-responsive center-block" src="${user.avatar}">
                        <hr>
                        <div align="center">
                            <form id="form_submit_photo" class="form-horizontal" role="form" action="/user/profile/saverawphoto/" method="post" enctype="multipart/form-data">
                                <label class="btn btn-default btn-file">
                                    更新头像
                                    <input id="ingredient_file" type="file" style="display: none;" name="photo" required="">
                                </label>
                            </form>


                            <div id="modal-info" class="modal modal-message modal-info fade" style="display: none;" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <i class="fa fa-envelope"></i>
                                        </div>
                                        <div id="clip_photo_title" class="modal-title">图片上传中</div>

                                        <div class="modal-body">
                                            <div id="progress-wrp">
                                                <div class="progress-bar"></div>
                                                <div class="status">0%</div>
                                            </div>
                                            <div align="center">
                                                <img id="uploaded_photo" src="">
                                                <img id="uploaded_photo_loading" src="../../../static/web/gif/img_loading.gif" style="display: none">
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <form id="form_upload_clippedphoto_btn" class="form-horizontal" role="form" action="/user/profile/saveclippedphoto/" method="post" enctype="multipart/form-data">
                                                <input type='hidden' name='csrfmiddlewaretoken' value='fWY6FJ9k4LmdrZAvTj14sYGiXDNpaeIibNmGGHi0mDWt2eiBjRP4XPZrVRpOnL2x'>
                                                <button id="upload_clippedphoto_btn" type="button" class="btn btn-info" data-dismiss="modal">选定头像</button>
                                            </form>
                                        </div>
                                    </div> <!-- / .modal-content -->
                                </div> <!-- / .modal-dialog -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-8 col-md-9">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="row" style="margin-left: 20px; margin-right: 20px;">
                            <h3>个人信息</h3>
                            <hr>
                            <form id="form_upload_profileinfo" class="form-horizontal" role="form" action="/updateProfile.do" method="post" enctype="multipart/form-data">

                                <div class="form-group">
                                    <label class="control-label col-md-3"><label for="id_username">用户名:</label></label>
                                    <div class="col-md-7"><input type="text" name="username" value="${logininfo.username}" class="form-control" maxlength="30" required="" id="id_username"></div>
                                    <span class="text-danger small"></span>
                                </div>

                                <div class="form-group">
                                    <label class="control-label col-md-3"><label for="id_truename">真实姓名:</label></label>
                                    <div class="col-md-7"><input type="text" name="truename" value="${user.truename}" class="form-control" maxlength="30" required="" id="id_truename"></div>
                                    <span class="text-danger small"></span>
                                </div>

                                <div class="form-group">
                                    <label class="control-label col-md-3"><label for="id_email">邮件地址:</label></label>
                                    <div class="col-md-7"><input type="email" name="email" value="${user.email}" class="form-control" style="margin-top: 0;" maxlength="50" required="" id="id_email"></div>
                                    <span class="text-danger small"></span>
                                </div>

                                <div class="form-group">
                                    <label class="control-label col-md-3"><label for="id_resume">个人简介:</label></label>
                                    <div class="col-md-7"><textarea name="introduce" cols="40" rows="4" class="form-control" maxlength="500" id="id_resume">${user.introduce}</textarea></div>
                                    <span class="text-danger small"></span>
                                </div>

                                <div class="form-group">
                                    <label class="control-label col-md-3"><label for="id_organization">年级专业:</label></label>
                                    <div class="col-md-7"><input type="text" name="grade" value="${user.grade}" class="form-control" maxlength="100" id="id_organization"></div>
                                    <span class="text-danger small"></span>
                                </div>

                                <div class="col-xs-offset-5">
                                    <button type="submit" class="btn btn-success" style="border-radius: 5px">更新信息</button>
                                </div>
                                <div>
                                    <span id="error_message_content" class="text-danger small"></span>
                                    <div id="modal-success" class="modal modal-message modal-success fade" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <i class="glyphicon glyphicon-check"></i>
                                                </div>
                                                <div id="success_message_content" class="modal-body"></div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-success" data-dismiss="modal">OK</button>
                                                </div>
                                            </div> <!-- / .modal-content -->
                                        </div> <!-- / .modal-dialog -->
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-offset-4 col-md-offset-3 col-sm-8 col-md-9">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="row" style="margin-left: 20px; margin-right: 20px;">
                            <h3>第三方登录</h3>
                            <hr>
                            <div class="row vertical-center">
                                <div class="col-xs-4">
                                    <img class="img" src="../../../static/web/img/third_party_icons/icon48_wx_logo.png" width="25px">
                                    &nbsp;微信
                                </div>

                                <div class="col-xs-4">
                                    未绑定
                                </div>
                                <div class="col-xs-4 text-right">
                                    <a id="third_party_weixin_connect_link" href="">绑定</a>
                                </div>

                            </div>
                            <div class="row vertical-center">
                                <div class="col-xs-4">
                                    <img class="img" src="../../../static/web/img/third_party_icons/qq.jpg" width="25px">
                                    &nbsp;QQ
                                </div>

                                <div class="col-xs-4">
                                    已绑定
                                </div>
                                <div class="col-xs-4 text-right">
                                    <a href="javascript:;">解绑</a>
                                </div>

                            </div>
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