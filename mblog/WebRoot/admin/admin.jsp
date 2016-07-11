<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="com.mblog.Po.*"%>
<%@page import="com.mblog.Do.*"%>
<%@page import="com.mblog.Do.impl.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>博客后台管理</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet" />

</head>

<body>
	<div id="loginout" class="modal fade bs-example-modal-sm" tabindex="-1"
		role="dialog" aria-labelledby="loginout">
		<div class="modal-dialog modal-sm">
			<form action="<%=basePath%>admin/Admin_logoutUser" method="get">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title">提示信息</h4>
					</div>
					<div class="modal-body">
						<p>亲,你真的要退出么?</p>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary">Yes</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">No</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<%
		session.setAttribute("url", "admin/admin.jsp");
	%>
	<!--下面是顶部导航栏的代码-->
	<nav class="navbar navbar-default navbar-inverse navbar-fixed-top"
		role="navigation">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#">博客后台管理</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="#">首页</a></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown">功能<span class="caret"></span></a>
					<ul class="dropdown-menu" role="menu">
						<li class="dropdown-header">管理员功能</li>
						<li><a href="<%=basePath%>/userlist/UserQuery">用户管理</a></li>
						<li><a href="<%=basePath%>/admin/page/lookthrough.jsp">日志管理</a></li>
						<li class="divider"></li>
					</ul></li>
				<li><a href="#">帮助</a></li>
			</ul>

			<s:if test="#session.admin!=null">
				<p class="navbar-form navbar-right" role="search">
					<button type="submit" class="btn btn-default">管理员:${session.admin.username},你好!</button>
					<button data-toggle="modal" data-target="#loginout"
						class="btn btn-default">注销</button>
				</p>
			</s:if>
			<s:else>
				<form class="navbar-form navbar-right"
					action="<%=basePath%>admin/Admin_adminLogin" role="search">
					<div class="form-group">
						<input type="text" class="form-control" name="admin.username"
							placeholder="用户名..."> <input type="password"
							class="form-control" name="admin.password" placeholder="密码...">
					</div>
					<button type="submit" class="btn btn-default">登录</button>
				</form>
			</s:else>
		</div>
	</div>
	</nav>

	<!―自适应布局-->
	<div class="container-fluid">
		<div class="row">
			<!―左侧导航栏-->

			<div class="col-sm-3 col-md-2 sidebar">
				<ul class="nav nav-sidebar">
					<li class="active"><a href="#">首页</a></li>
				</ul>
				<ul class="nav nav-sidebar">
					<!-- 
					<li><a href="<%=basePath%>admin/page/userlist.jsp">用户管理</a></li> -->
					<li><a href="<%=basePath%>/userlist/UserQuery">用户管理</a></li>
					<li><a href="<%=basePath%>/admin/page/lookthrough.jsp">日志管理</a></li>

				</ul>
				<ul class="nav nav-sidebar">
					<li><a href="#">设置</a></li>
					<li><a href="#">帮助</a></li>
				</ul>
			</div>
			<!―右侧管理控制台-->
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<h1 class="page-header">管理控制台</h1>
				<div class="row">
					<div class="col-md-6">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h3 class="panel-title">最新发布</h3>
							</div>
							<div class="panel-body">
								<table class="table table-striped">
									<thead>
										<tr>
											<th>ID</th>
											<th>分类</th>
											<th>标题</th>
											<th>发布时间</th>
											<th>作者</th>
										</tr>
									</thead>
									<tbody>
										<%
											ArticlescrapDAO aDAO = new ArticlescrapDAOImpl();
											List list = aDAO.queryArticle(0, 4);
											for (int i = 0; i < list.size(); i++) {
												Articlescrap a = (Articlescrap) list.get(i);
										%>
										<tr>
											<td><%=a.getAid()%></td>
											<td>
												<%
													if (a.getAtype() == 0) {
												%> 说说 <%
													} else {
												%> 日志 <%
													}
												%>
											</td>
											<td><%=a.getTitle()%></td>
											<td><%=a.getTime()%></td>
											<td><%=a.getUserinfo().getUiNickname()%></td>
										</tr>
										<%
											}
										%>
									</tbody>
								</table>
								<p>
									<a class="btn btn-primary"
										href="<%=basePath%>admin/page/lookthrough.jsp" role="button">查看详细&raquo;</a>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>

</body>
</html>


