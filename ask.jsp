<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 引入struts2标签 -->
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<head>
<title>SUW-search you want</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 引入 Bootstrap -->
<link href="${pageContext.request.contextPath }/css/bootstrap.min.css"
	rel="stylesheet" type="text/css">
<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
<script src="${pageContext.request.contextPath }/js/jquery.js"></script>
<!-- 包括所有已编译的插件 -->
<script src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>

<link
	href="${pageContext.request.contextPath }/external/google-code-prettify/prettify.css"
	rel="stylesheet">
<link
	href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/css/bootstrap-responsive.min.css"
	rel="stylesheet">
<link
	href="http://netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/index.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath }/external/jquery.hotkeys.js"></script>
<script
	src="${pageContext.request.contextPath }/external/google-code-prettify/prettify.js"></script>
<script
	src="${pageContext.request.contextPath }/js/bootstrap-wysiwyg.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#editor").focus(function() {
			if ($("#editor").html().trim() == "Question Body") {
				$("#editor").html("");
			}
		});
		$("#editor").blur(function() {
			if ($("#editor").html().trim() == "") {
				$("#editor").html("Question Body");
			}
		});
		
		$("#editor").keydown(function(){
			$("#voiceBtn").val($("#editor").html());
		});
		$(":submit[id^='sub']").click(function(check) {
			var userId = $("#userId").val();
			if ('' == userId) {
				alert("please login at first");
				return false;
			}
		});
	});
</script>
</head>
<body>
	<input type="text" class="hidden" id="userId" value="${user.id }" />
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<ul id="headnav" class="nav nav-pills">
					<li class="active"><a
						href="${pageContext.request.contextPath }/index.jsp">LOGO</a></li>
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
								class="caret "></span><span class="badge ">2</span>
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

		<div class="row">
			<div class="col-md-8">
				<form method="post" action="${pageContext.request.contextPath }/question/addQuestion.action">
				<div class="form-group">

					<input type="text" class="form-control" id="title" name="question.title"
						placeholder="Title: use one sentence states your question.">
				</div>
				<div class="form-group ">
					<input type="text" class="form-control" id="tag"  name="question.tags"
						placeholder="tag,for example : python,django ,you can use coomma or semicolon to 
separate">
				</div>
				<div class="btn-toolbar" data-role="editor-toolbar"
					data-target="#editor">
					<div class="btn-group">
						<a class="btn" data-edit="bold" title="Bold (Ctrl/Cmd+B)"><i
							class="icon-bold"></i></a> <a class="btn" data-edit="italic"
							title="Italic (Ctrl/Cmd+I)"> <i class="icon-italic"></i>
						</a>

					</div>
					<div class="btn-group">
						<a class="btn dropdown-toggle" data-toggle="dropdown"
							title="Hyperlink"><i class="icon-link"></i></a>
						<div class="dropdown-menu input-append">
							<input class="span2" placeholder="URL" type="text"
								data-edit="createLink" />
							<button class="btn" type="button">Add</button>
						</div>
						<a class="btn" data-edit="unlink" title="Remove Hyperlink"><i
							class="icon-cut"></i></a>

					</div>
					<div class="btn-group">
						<a class="btn" data-edit="undo" title="Undo (Ctrl/Cmd+Z)"><i
							class="icon-undo"></i></a> <a class="btn" data-edit="redo"
							title="Redo (Ctrl/Cmd+Y)"><i class="icon-repeat"></i></a>
					</div>
					<input type="text" data-edit="inserttext" id="voiceBtn" name="question.body"
						x-webkit-speech="" />
				</div>

				<div id="editor" contenteditable="true">Question Body</div>

				<div class="form-group">
					<button type="submit" id="sub"
						class="btn btn-default drdropdown pull-left">submit</button>
				</div>
				</form>
			</div>
			<div class="col-md-3 ">
				<div class="jumbotron">
					<h3>Notice:</h3>
					<p style="font-size: 10px;">if you want to add <span style="color:RED;"> code </span>, please
						write between #code# and #/code#, like:</p>
					<p style="font-size: 10px; color: RED;">
						#code# <br /> .....(your code) <br /> #/code#
					</p>
					<p style="font-size: 10px;">
					if your want show you information like <code>undefined</code>, please write your question between #light# and #/light#. like
					</p>
					<p style="font-size: 10px; color: RED;">
						#light# <br /> .....(your code) <br /> #/light#
					</p>
				</div>
			</div>
		</div>
</body>
<script>
	$(function() {
		function initToolbarBootstrapBindings() {
			var fonts = [ 'Serif', 'Sans', 'Arial', 'Arial Black', 'Courier',
					'Courier New', 'Comic Sans MS', 'Helvetica', 'Impact',
					'Lucida Grande', 'Lucida Sans', 'Tahoma', 'Times',
					'Times New Roman', 'Verdana' ], fontTarget = $(
					'[title=Font]').siblings('.dropdown-menu');
			$
					.each(
							fonts,
							function(idx, fontName) {
								fontTarget
										.append($('<li><a data-edit="fontName ' + fontName +'" style="font-family:\''+ fontName +'\'">'
												+ fontName + '</a></li>'));
							});
			$('a[title]').tooltip({
				container : 'body'
			});
			$('.dropdown-menu input').click(function() {
				return false;
			}).change(
					function() {
						$(this).parent('.dropdown-menu').siblings(
								'.dropdown-toggle').dropdown('toggle');
					}).keydown('esc', function() {
				this.value = '';
				$(this).change();
			});

			$('[data-role=magic-overlay]').each(
					function() {
						var overlay = $(this), target = $(overlay
								.data('target'));
						overlay.css('opacity', 0).css('position', 'absolute')
								.offset(target.offset()).width(
										target.outerWidth()).height(
										target.outerHeight());
					});
			if ("onwebkitspeechchange" in document.createElement("input")) {
				var editorOffset = $('#editor').offset();
				$('#voiceBtn').css('position', 'absolute').offset({
					top : editorOffset.top,
					left : editorOffset.left + $('#editor').innerWidth() - 35
				});
			} else {
				$('#voiceBtn').hide();
			}
		}
		;
		function showErrorAlert(reason, detail) {
			var msg = '';
			if (reason === 'unsupported-file-type') {
				msg = "Unsupported format " + detail;
			} else {
				console.log("error uploading file", reason, detail);
			}
			$(
					'<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>'
							+ '<strong>File upload error</strong> '
							+ msg
							+ ' </div>').prependTo('#alerts');
		}
		;
		initToolbarBootstrapBindings();
		$('#editor').wysiwyg({
			fileUploadError : showErrorAlert
		});
		window.prettyPrint && prettyPrint();
	});
</script>
</html>
