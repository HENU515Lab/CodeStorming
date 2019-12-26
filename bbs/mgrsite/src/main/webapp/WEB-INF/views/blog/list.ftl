<!DOCTYPE html>
<html>
<head>
    <title>AdminLTE 3 | DataTables</title>
    <#include "../common/links-tpl.ftl" />
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
    <!-- Navbar -->
    <#include "../common/navbar-tpl.ftl" />
    <!-- /.navbar -->

    <!-- Main Sidebar Container -->
    <#include "../common/admin-sidebar-tpl.ftl" />

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>文章管理</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">分享管理</a></li>
                            <li class="breadcrumb-item active">文章管理</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <!-- /.card-header -->
                        <div class="card-body">
                            <table id="users" class="table table-bordered table-striped">
                                <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>标题</th>
                                    <th>作者</th>
                                    <th>阅读量</th>
                                    <th>点赞</th>
                                    <th>权重</th>
                                    <th>文章类型</th>
                                    <th>创建时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <#list blogList as blog>
                                    <tr>
                                        <td>${blog.id}</td>
                                        <td><#if blog.title?length lt 20>${(blog.title)?default("")}
                                            <#else>${(blog.title[0..10]?default(""))}...</#if></td>
                                        <td>${blog.author.username}</td>
                                        <td>${blog.readSize}</td>
                                        <td>${blog.voteSize}</td>
                                        <td>${blog.weight}</td>
                                        <td>${blog.blogType}</td>
                                        <td>${blog.createTime?string('yyyy-MM-dd hh:mm:ss')}</td>
                                        <td>
                                            <button type="button" class="btn btn-sm btn-warning" data-toggle="modal"
                                                    data-target="#edit-modal" onclick="itemEdit(${blog.id})">
                                                编辑
                                            </button>
                                            <button type="button" class="btn btn-sm btn-danger" data-toggle="modal"
                                                    data-target="#remove-modal" onclick="itemRemove(${blog.id})">
                                                删除
                                            </button>
                                        </td>
                                    </tr>
                                </#list>
                                </tbody>
                            </table>
                        </div>
                        <!-- /.card-body -->
                    </div>
                    <!-- /.card -->
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </section>
        <!-- /.content -->
    </div>

    <!-- Edit Modal -->
    <div class="modal fade" id="edit-modal" tabindex="-1" role="dialog"
               aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalCenterTitle">编辑文章信息</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div id="edit-modal-form">

                </div>
            </div>
        </div>
    </div>
    <!-- Remove Modal -->
    <div class="modal fade" id="remove-modal" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">您确定要删除文章吗？</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div id="remove-modal-form">

                </div>
            </div>
        </div>
    </div>

    <!-- /.content-wrapper -->
    <#include "../common/footer-tpl.ftl" />

    <!-- Control Sidebar -->
    <#include "../common/control-sidebar-tpl.ftl" />
    <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->


<!-- jQuery -->
<script src="static/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="static/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- DataTables -->
<script src="static/plugins/datatables/jquery.dataTables.js"></script>
<script src="static/plugins/datatables-bs4/js/dataTables.bootstrap4.js"></script>
<!-- AdminLTE App -->
<script src="static/dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="static/dist/js/demo.js"></script>
<!-- toastr -->
<script src="static/plugins/toastr/toastr.min.js"></script>
<!-- page script -->
<script>
    $(function () {
        $("#users").DataTable({
            "processing": true,
            "bFilter": true,
            "oLanguage":    //DataTable中文化 把提示语之类的换成中文
                {
                    "sProcessing": "正在加载中......",
                    "sLengthMenu": "每页显示 _MENU_ 条记录",
                    "sZeroRecords": "对不起，查询不到相关数据！",
                    "sEmptyTable": "表中无数据存在！",
                    "sInfo": "当前显示 _START_ 到 _END_ 条，共 _TOTAL_ 条记录",
                    "sInfoFiltered": "数据表中共为 _MAX_ 条记录",
                    "sSearch": "搜索",
                    "oPaginate": {
                        "sFirst": "首页",
                        "sPrevious": "上一页",
                        "sNext": "下一页",
                        "sLast": "末页"
                    }
                },

        });



    });

    function itemEdit(id) {
        $.ajax({
            url: '/blogItemEdit.do?id=' + id,
            type: "GET",
            cache: false,
            timeout: 60000,
            success: function (response) {
                var form_content = '<form id="edit-form" action="/blogItemUpdate.do">\n' +
                    '<div class="modal-body">\n' +
                    '    <div class="form-group">\n' +
                    '        <label class="col-form-label">文章标题</label>\n' +
                    '        <input type="text" class="form-control" name="title" value="'+response.title+'">\n' +
                    '    </div>\n' +
                    '    <div class="form-group">\n' +
                    '        <label class="col-form-label">权重</label>\n' +
                    '        <input type="text" class="form-control" name="weight" value="'+response.weight+'">\n' +
                    '    </div>\n' +
                    '    <div class="form-group">\n' +
                    '        <label class="col-form-label">文章类型（0为实验室成员权限，1为普通用户权限）</label>\n' +
                    '        <input type="text" class="form-control" name="blogType" value="'+response.type+'">\n' +
                    '    </div>\n' +
                    '</div>\n' +
                    '<input type="hidden" class="form-control" name="id" value="'+id+'">\n' +
                    '<div class="modal-footer">\n' +
                    '    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>\n' +
                    '    <button onclick="blogItemUpdate()" type="button" class="btn btn-success" id="edit-modal-submit">保存修改</button>\n' +
                    '</div>\n' +
                    '</form>'
                $('#edit-modal-form').html(form_content)
            },
            error: function () {

            }
        })
    }

    function itemRemove(id) {
        $.ajax({
            url: '/blogItemRemove.do?id=' + id,
            type: "GET",
            cache: false,
            timeout: 60000,
            success: function (response) {
                var form_content = '<form id="remove-form">\n' +
                    '    <div class="modal-footer">\n' +
                    '        <input type="hidden" name="id" value="'+id+'" />\n' +
                    '        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>\n' +
                    '        <button onclick="blogItemRemove()" type="button" class="btn btn-danger" id="remove-modal-submit">删除</button>\n' +
                    '    </div>\n' +
                    '</form>'
                $('#remove-modal-form').html(form_content)
            },
            error: function () {

            }
        })
    }

    function blogItemUpdate() {
        $('#edit-modal-submit').addClass('disabled')
        let hrefUrl = '/blogItemUpdate.do'
        let postData = $('#edit-form').serializeArray();
        $.ajax({
            url: hrefUrl,
            type: "POST",
            data: postData,
            dataType: "Json",
            cache: false,
            timeout: 60000,
            success: function (resp) {
                // $('#edit-modal-success').modal('show')
                toastr.success('文章信息修改成功')
                setTimeout("location.href = '" + '/toBlogMgr.do' + "'", 1000)
            },
            error: function () {
                toastr.fail('文章信息修改失败')
            }
        })
    }

    function blogItemRemove() {
        $('#remove-modal-submit').addClass('disabled')
        let hrefUrl = '/blogItemDelete.do'
        let postData = $('#remove-form').serializeArray();
        $.ajax({
            url: hrefUrl,
            type: "POST",
            data: postData,
            dataType: "Json",
            cache: false,
            timeout: 60000,
            success: function (resp) {
                toastr.success('文章删除成功')
                setTimeout("location.href = '" + '/toBlogMgr.do' + "'", 1000)
            },
            error: function () {
                toastr.fail('文章删除失败')
            }
        })
    }

</script>
</body>
</html>
