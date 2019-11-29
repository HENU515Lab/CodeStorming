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
            <h1>用户管理</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">系统管理</a></li>
              <li class="breadcrumb-item active">用户管理</li>
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
<#--            <div class="card-header">-->
<#--              <h3 class="card-title">网站所有用户</h3>-->
<#--            </div>-->
            <!-- /.card-header -->
            <div class="card-body">
              <table id="users" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th>id</th>
                  <th>用户名</th>
                  <th>年级专业</th>
                  <th>真实姓名</th>
                  <th>电子邮件</th>
                  <th>访问量</th>
                </tr>
                </thead>
                <tbody>
                  <#list userList as user>
                    <tr>
                      <td>${user.id}</td>
                      <td>${user.username}</td>
                      <td>${user.grade}</td>
                      <td>${user.truename}</td>
                      <td>${user.email}</td>
                      <td>${user.visitors}</td>
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
<!-- page script -->
<script>
  $(function () {
    $("#users").DataTable();
    // $('#example2').DataTable({
    //   "paging": true,
    //   "lengthChange": false,
    //   "searching": false,
    //   "ordering": true,
    //   "info": true,
    //   "autoWidth": false,
    // });
  });
</script>
</body>
</html>
