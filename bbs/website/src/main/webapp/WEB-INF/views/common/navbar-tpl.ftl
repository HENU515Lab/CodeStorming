<nav class="navbar navbar-inverse navbar-fixed-top" style="z-index: 10;">
	<div class="container">
		<!-- Header -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#topNavBar">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>

			</button>
			<a class="navbar-brand" href="/index.do">515lab</a>
		</div>

		<!-- Items -->
		<div class="collapse navbar-collapse" id="topNavBar">
			<ul class="nav navbar-nav">
				<li id="index"><a href="/index.do">首页</a></li>
<#--				<li class=""><a href="problem/Index.html">题库</a></li>-->
<#--				<li>-->
<#--					<a href="" class="dropdown-toggle " data-toggle="dropdown">-->
<#--						题解-->
<#--						<b class="caret"></b>-->
<#--					</a>-->
<#--					<ul class="dropdown-menu">-->
<#--						<li><a href="solution/leetcode/Index.html">LeetCode</a></li>-->
<#--						<li><a href="solution/acwing/Index.html">AcWing</a></li>-->
<#--					</ul>-->
<#--				</li>-->
				<li id="blog" class=""><a href="blog.do">分享</a></li>
				<li id="community" class=""><a href="community.do">问答</a></li>
				<li id="activity" class=""><a href="activity.do">活动</a></li>
<#--				<li class=""><a href="http_wss/danmu/world/Index.html">吐槽</a></li>-->
			</ul>


			<ul class="nav navbar-nav navbar-right">
				<#if !logininfo??>
				<li>
					<a href="" data-toggle="modal" data-target="#login-modal">登录/注册</a>
				</li>
				<#else>
				<li>
					<a href="/userspace.do?id=${user.id}">
						<span class="glyphicon glyphicon-bell" style="font-size: 20px;"></span>
					</a>
				</li>
				<li>
					<a href="" class="dropdown-toggle" data-toggle="dropdown">
						<img class="img-circle" src="static/web/img/default-avatar.jpg" alt="${logininfo.username}的头像" style="margin: -5px;" width="35px">
						&nbsp;
						<strong id="id_user_username">${logininfo.username}</strong>
						<b class="caret"></b>
					</a>
					<ul class="dropdown-menu">
						<li><a href="userspace.do?id=${logininfo.id}">我的空间</a></li>
						<li><a href="/profile.do">个人信息</a></li>
						<li><a href="user/account/changepassword/Index.html">修改密码</a></li>
						<li class="divider"></li>
						<li><a href="/logout.do">登出</a></li>
					</ul>
				</li>
				</#if>

			</ul>
		</div>
	</div>
</nav>


<div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
	 style="display: none;">
	<div class="modal-dialog" style="width: 85%; max-width: 350px;">
		<div class="modal-content">
			<div class="modal-header" align="center">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
				</button>
				<span class="acwing-brand">515lab</span>
			</div>

			<!-- Begin # DIV Form -->
			<div id="div-forms">

				<!-- Begin # Login Form -->
				<form class="sign-form" id="login-form" role="form" action="/login.do" method="post"
					  enctype="multipart/form-data">
					<div class="modal-body">
						<div id="div-login-msg">
							<div id="icon-login-msg" class="glyphicon glyphicon-chevron-right"></div>
							<span id="text-login-msg">请输入登录信息</span>
						</div>
						<input id="login_username" name="username" class="form-control" type="text" placeholder="用户名或邮箱"
							   maxlength="30" required="">
						<input id="login_password" name="password" class="form-control" type="password" placeholder="密码"
							   maxlength="16" required="">
						<div class="checkbox">
							<label>
								<input id="login_remember_me" name="remember_me" type="checkbox" checked="checked"> 记住我
							</label>
						</div>
					</div>
					<div class="modal-footer">
						<div>
							<button type="submit" class="btn btn-primary btn-lg btn-block">登录</button>
						</div>
						<div>
							<div style="width:50%;padding:0;margin:0;float:left;box-sizing:border-box;" align="left">
								<button id="login_lost_btn" type="button" class="btn btn-link">忘记密码</button>
							</div>
							<div style="width:50%;padding:0;margin:0;float:left;box-sizing:border-box;" align="right">
								<button id="login_register_btn" type="button" class="btn btn-link">注册</button>
							</div>
						</div>
						<div>
							更多登录方式：
							<a id="third_party_weixin_connect_link_base" href="">
								<img class="img" src="static/web/img/third_party_icons/icon48_wx_logo.png" width="30px"
									 alt="微信图标">
							</a>
							<a href="third_party/qq/login/apply_code.html">
								<img class="img" src="static/web/img/third_party_icons/qq.jpg" width="26px" alt="qq图标">
							</a>
						</div>
					</div>
				</form>
				<!-- End # Login Form -->

				<!-- Begin | Lost Password Form -->
				<form class="sign-form" id="lost-form" role="form" action="/user/account/password_forget/" method="post"
					  enctype="multipart/form-data" style="display:none;">
					<div class="modal-body">
						<div id="div-lost-msg">
							<div id="icon-lost-msg" class="glyphicon glyphicon-chevron-right"></div>
							<span id="text-lost-msg">请输入绑定的邮箱地址</span>
						</div>
						<input id="lost_email" name="email" class="form-control" type="email" placeholder="邮箱地址"
							   maxlength="254" required="">
					</div>
					<div class="modal-footer">
						<div>
							<button type="submit" id="lost_password_btn" class="btn btn-primary btn-lg btn-block">发送
							</button>
						</div>
						<div>
							<div style="width:50%;padding:0;margin:0;float:left;box-sizing:border-box;" align="left">
								<button id="lost_login_btn" type="button" class="btn btn-link">登录</button>
							</div>
							<div style="width:50%;padding:0;margin:0;float:left;box-sizing:border-box;" align="right">
								<button id="lost_register_btn" type="button" class="btn btn-link">注册</button>
							</div>
						</div>
					</div>
				</form>
				<!-- End | Lost Password Form -->

				<!-- Begin | Register Form -->
				<form class="sign-form" id="register-form" role="form" action="/register.do" method="post"
					  enctype="multipart/form-data" style="display:none;">
					<div class="modal-body">
						<div id="div-register-msg">
							<div id="icon-register-msg" class="glyphicon glyphicon-chevron-right"></div>
							<span id="text-register-msg">请输入注册信息</span>
						</div>
						<input id="register_username" name="username" class="form-control" type="text" placeholder="用户名"
							   maxlength="30" required="">
						<input id="register_password" name="password" class="form-control" type="password"
							   placeholder="密码" maxlength="16" required="">
						<input id="register_email" name="email" class="form-control" type="email" placeholder="邮箱地址"
							   maxlength="50" required="">
					</div>
					<div class="modal-footer">
						<div>
							<button type="submit" class="btn btn-primary btn-lg btn-block">注册</button>
						</div>
						<div align="right">
							<button id="register_login_btn" type="button" class="btn btn-link">登录</button>
						</div>
					</div>
				</form>
				<!-- End | Register Form -->

			</div>
			<!-- End # DIV Form -->

		</div>
	</div>
</div>
<!-- END # MODAL LOGIN -->

<#if currentNav??>
<script type="text/javascript">
	$("#"+"${currentNav}").addClass("active");
</script>
</#if>