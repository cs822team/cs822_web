<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 引入struts2标签 -->
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>


<div class="row">
	<div class="col-md-12">
		<ul id="headnav" class="nav nav-pills">
			<li class="active"><a href="#">LOGO</a></li>
			<form class="form-search navbar-left drdropdown pull-right">
				<input class="input-medium search-query" type="text"
					placeholder="Search  U Want" />
				<button type="submit" class="btn btn-primary" id="but1">
					<span class="glyphicon glyphicon-search"></span>SEARCH
				</button>
			</form>
			<s:if test="#session.user==null">
				<li class="drdropdown pull-right"><a href="#"
					data-toggle="modal" data-target="#myModal">log in</a></li>
				<li class="drdropdown pull-right"><a href="#"
					data-toggle="modal" data-target="#registModal">sign up</a></li>
				<li class="drdropdown pull-right"><a href="#"> help </a></li>

			</s:if>
			<s:if test="#session.user!=null">
				<li class="dropdown pull-right"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"> ${user.displayName } <span
						class="caret "></span><span class="badge ">
							<!-- 2 -->
					</span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="#">MY SETTING</a></li>
						<li><a href="#">MY Q&A</a></li>
						<li><a href="#">Regist</a></li>
						<li class="divider"></li>
						<li><a
							href="${pageContext.request.contextPath }/user/logout.action">EXIT</a></li>
					</ul></li>
			</s:if>
		</ul>
	</div>
</div>








