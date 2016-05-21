<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<head>

<title>FQA</title>
<meta charset="UTF-8">
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
						var path = $("#path").val();
						$(function() {
							$("#returnPath").val(
									window.location.pathname
											+ window.location.search);
							$("#returnPath2").val(
									window.location.pathname
											+ window.location.search);
							$("#smallGroup")
									.html(
											"<button type='button' class='btn  btn-info pull-left  ' id='fun_hot' value='1' >Hot</button>"
													+ "<button type='button' class='btn btn-default  pull-left' id='fun_recommend' value='2'>Recommend</button>");
							$
									.ajax({
										url : path + '/question/hot.action',
										type : 'POST',
										data : "",
										dataType : 'json',
										success : function(data) {
											$(data.questions)
													.each(
															function(i, value) {
																$(
																		"#smallGroupContent")
																		.append(
																				"<tr>"
																						+ "<td><a href='"
																						+ path
																						+ "/question/scan.action?question.id="
																						+ value.id
																						+ "'>"
																						+ value.title
																						+ "</a></td>"
																						+ "</tr>");
															});
										}
									});
						});
						$("#editor").focus(function() {
											if ($("#editor").html().trim() == "Write answer at here...keep cool") {
												$("#editor").html("");
											}
										});
						$("#editor").blur(function() {
											if ($("#editor").html().trim() == "") {
												$("#editor")
														.html(
																"Write answer at here...keep cool");
											}
										});
						$("#showMoreComments").click(function() {
							$('[id^="com_"]').removeClass("hidden");
							$('[id^="com_"]').addClass("show");
							$('#showMoreComments').addClass("hidden");
							$('#foldComments').removeClass("hidden");
							$('#foldComments').addClass("show");
						});
						$("#foldComments").click(function() {
							$('[id^="com_"]').removeClass("show");
							$('[id^="com_"]').addClass("hidden");
							$('#foldComments').addClass("hidden");
							$('#showMoreComments').removeClass("hidden");
							$('#showMoreComments').addClass("show");
						});
						$("#thumbUp")
								.click(
										function() {
											var questionId = $("#questionId")
													.val();
											$
													.ajax({
														url : path
																+ '/question/vote.action?voteValue=1&question.id='
																+ questionId,
														type : 'POST',
														data : "",
														dataType : 'json',
														success : function(data) {
															$("#voteNumber")
																	.html(
																			parseInt($(
																					"#voteNumber")
																					.html()) + 1);
														}
													});
										});
						$("#thumbDown")
								.click(
										function() {
											var questionId = $("#questionId")
													.val();
											$
													.ajax({
														url : path
																+ '/question/vote.action?voteValue=-1&question.id='
																+ questionId,
														type : 'POST',
														data : "",
														dataType : 'json',
														success : function(data) {
															$("#voteNumber")
																	.html(
																			parseInt($(
																					"#voteNumber")
																					.html()) - 1);
														}
													});
										});

						$(":submit[id^='submitAnswer']").click(function(check) {
							var userId = $("#userId").val();
							if ('' == userId) {
								alert("please login at first");
								return false;
							}
							$("#answerBody").val($("#editor").html());

						});
						$("#comment")
								.focus(
										function() {
											if ($("#comment").html().trim() == "input your comment at here.") {
												$("#comment").html("");
											}
										});
						$("#comment").blur(
								function() {
									if ($("#comment").html().trim() == "") {
										$("#comment").html(
												"input your comment at here.");
									}
								});
						$("#addComment")
								.click(
										function() {

											var userId = $("#userId").val();
											var questionId = $("#questionId")
													.val();
											var commentContent = $("#comment")
													.val();
											if (commentContent.trim() == "input your comment at here.") {
												alert("Please insert your comment");
												return false;
											}
											if (userId == '') {
												alert("please login at first");
												return false;
											}
											$
													.ajax({
														url : path
																+ '/comment/add.action?comment.text='
																+ commentContent
																+ '&comment.userId='
																+ userId
																+ '&questionId='
																+ questionId,
														type : 'POST',
														data : "",
														dataType : 'json',
														success : function(data) {
															$(data.comment)
																	.each(
																			function(
																					i,
																					value) {
																				var htmlCode = "<div class='alert alert-success' role='alert' style='margin-bottom: 0px;'>"
																						+ "<h4>" + $("#userDisplayname").val() +"</h4>&nbsp;&nbsp;&nbsp;&nbsp;"
																						+ value.text
																						+ "</div>";
																				$(
																						"#beforeComment")
																						.after(
																								htmlCode);
																			});
														}
													});
										});
						$('#smallGroup')
								.delegate(
										'[id^="fun_"]',
										'click',
										function() {
											var path = $("#path").val();
											if (this.value == 1) {
												$("#smallGroup")
														.html(
																"<button type='button' class='btn  btn-info pull-left  ' id='fun_hot' value='1' >Hot</button>"
																		+ "<button type='button' class='btn btn-default  pull-left' id='fun_recommend' value='2'>Recommend</button>");
												$
														.ajax({
															url : path
																	+ '/question/hot.action',
															type : 'POST',
															data : "",
															dataType : 'json',
															success : function(
																	data) {
																$(
																		"#smallGroupContent")
																		.html(
																				"");
																$(
																		data.questions)
																		.each(
																				function(
																						i,
																						value) {
																					$(
																							"#smallGroupContent")
																							.append(
																									"<tr>"
																											+ "<td><a href='#'>"
																											+ value.title
																											+ "</a></td>"
																											+ "</tr>");

																				});
															}
														});
											} else {
												$("#smallGroup")
														.html(
																"<button type='button' class='btn btn-info  pull-left' id='fun_recommend' value='2'>Recommend</button>"
																		+ "<button type='button' class='btn  btn-default pull-left  ' id='fun_hot' value='1' >Hot</button><span id='fun_refresh'  class='glyphicon glyphicon-refresh pull-right' aria-hidden='true'></span>");
												$
														.ajax({
															url : path
																	+ '/question/questionsRecommend.action',
															type : 'POST',
															data : "",
															dataType : 'json',
															success : function(
																	data) {
																$(
																		"#smallGroupContent")
																		.html(
																				"");
																var htmlValue = "smallGroupContent";
																$(
																		data.questions)
																		.each(
																				function(
																						i,
																						value) {
																					$(
																							"#smallGroupContent")
																							.append(
																									"<tr>"
																											+ "<td><a href='"
																											+ path
																											+ "/question/scan.action?question.id="
																											+ value.id
																											+ "'>"
																											+ value.title
																											+ "</a></td>"
																											+ "</tr>");

																				});
															}
														});
											}
										});
						$("#collect").hover(function(){
							$("#collectSpan").removeClass("hidden");
						},function(){
							$("#collectSpan").addClass("hidden");
						});
						$("#collect").click(function(){
							/* if($("#collect").hasClass("btn-success")){
								$("#collect").removeClass("btn-success");
								$("#collect").addClass("btn-default");
							}else{
								$("#collect").removeClass("btn-default");
								$("#collect").removeClass("btn-success");
								$("#collect").addClass("btn-success");
							} */
							/* var flag = $("#collect").hasClass("btn-success"); */
							if($("#userId").val()==""){
								alert("please login first");
								return;
							}
							var realPath;
							if(!$("#collect").hasClass("btn-success")){
								realPath = path
								+ '/question/favourite.action?favourite.questionId='+$("#questionId").val()+'&favourite.userId='+$("#userId").val();
							}else{
								realPath = path
								+ '/question/unfavourite.action?favourite.questionId='+$("#questionId").val()+'&favourite.userId='+$("#userId").val();
							}
							$.ajax({
								url : realPath,
								type : 'POST',
								data : "",
								dataType : 'json',
								success : function(data) {
									if($("#collect").hasClass("btn-success")){
										$("#collect").removeClass("btn-success");
										$("#collect").addClass("btn-default");
									}else{
										$("#collect").removeClass("btn-default");
										$("#collect").removeClass("btn-success");
										$("#collect").addClass("btn-success");
									}
								}
							});
						});
						
						
						$("button[id^='ForAnswer']").click(function() {
							var voteValue = $(this).attr("id").indexOf("Up")>0?1:-1;
							$.ajax({
										url : path
												+ '/answer/vote.action?voteValue='+voteValue+'&answer.id='
												+ $(this).val(),
										type : 'POST',
										data : "",
										dataType : 'json',
										success : function(data) {
											$("#voteNumberForAnswer")
													.html(
															parseInt($(
																	"#voteNumberForAnswer")
																	.html())+voteValue);
										}
									});
								});
						 
						$("button[id^='editAnswer_']").on("click",function() {
							var id = $(this).attr("id").replace("editAnswer","answerBodyForEdit");
							$("#editor").html($("#"+id).text().trim());
							$("#updateAnswer").removeClass("hidden");
							$("#undoUpdateAnswer").removeClass("hidden");
							$("#submitAnswer").addClass("hidden");
							$("#answerForm").attr("action", path+"/answer/updateAnswer.action");
							$("#answerId").val($(this).val());
							
							}); 
						$("#undoUpdateAnswer").click(function() {
							$("#editor").html("Write answer at here...keep cool");
							$("#updateAnswer").addClass("hidden");
							$("#undoUpdateAnswer").addClass("hidden");
							$("#submitAnswer").removeClass("hidden");
							$("#answerForm").attr("action", path+"/question/addAnswer.action");
							$("#updateOoNot").val("0");
							}); 
						
						
						
						
						$("#updateAnswer").click(function() {
							$("#answerBody").val($("#editor").html());
							
							}); 
						
				
						
						
						
					});
</script>

</head>
<body style="position: relative;">
	
	<input id="path" type="hidden"
		value="${pageContext.request.contextPath }" />
	<input type="text"  class="hidden" id="userId" value="${user.id }" />
	<input type="text"  class="hidden" id="fa" value="${fa }" />
	<input type="text" class="hidden" id="userDisplayname"
		value="${user.displayName }" />
	<input type="text" class="hidden" id="questionId"
		value="${question.id }" />
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
		<div
			style="position: fixed; top: 220px; left: 20px; width: 300px; height: 300px;">
			<s:if test="#request.fa">
			<button type="button" class="btn btn-success "
				aria-label="Left Align" id="collect">
				<span class="glyphicon glyphicon glyphicon glyphicon-star-empty"
					aria-hidden="true"></span> <span id="collectSpan" class="hidden">
					Favourite </span>
			</button>
			</s:if>
			<s:else>
			<button type="button" class="btn btn-default "
				aria-label="Left Align" id="collect">
				<span class="glyphicon glyphicon glyphicon glyphicon-star-empty"
					aria-hidden="true"></span> <span id="collectSpan" class="hidden">
					Favourite </span>
			</button>
			</s:else>
			
			<br /> <br />

			<button type="button" class="btn btn-success "
				aria-label="Left Align" id="thumbUp">
				<span class="glyphicon glyphicon glyphicon-thumbs-up"
					aria-hidden="true"></span>
			</button>
			<br /> <br />
			<h3>
				<span class="label label-info" id="voteNumber">${request.question.vote}</span>
			</h3>
			<br /> <br />
			<button type="button" class="btn btn-success "
				aria-label="Left Align" id="thumbDown">
				<span class="glyphicon glyphicon glyphicon-thumbs-down"
					aria-hidden="true"></span>
			</button>
		</div>
		<div class="row">
			<div class="col-md-12 btn-group-xs">
				<div class="btn-group" id="hotTargets"></div>
			</div>
		</div>
		<div class="row ">
			<div class="col-md-8">

				<table class="table" id="beforeComment">

					<thead>
						<tr>
							<th><h1>${question.title }</h1></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td id="body">${request.question.body}</td>

						</tr>
						<tr>
							<td><B>Comments</B></td>
						</tr>
					</tbody>
				</table>

				<s:iterator var="com" value="#request.question.comments" status="st">
					<s:if test="#st.index<=3">
						<div class="alert alert-success" role="alert"
							style="margin-bottom: 0px;">
							<h4>
								<i><s:property value="#com.displayName" />:</i>
							</h4>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<s:property value="#com.text" />
						</div>
					</s:if>
					<s:else>
						<div class="alert alert-success hidden " role="alert"
							style="margin-bottom: 0px;"
							id='com_<s:property value="#st.index"/>'>
							<s:property value="#com.text" />
						</div>
					</s:else>
					<s:if test="#st.last ">
						<s:if test="#st.index>3">
							<div id="showMoreComments">
								<span class="label label-info pull-right">show more</span>
							</div>
							<div class="hidden" id="foldComments">
								<span class="label label-info pull-right">folding</span>
							</div>
						</s:if>
					</s:if>
				</s:iterator>

				<BR />
				<div contenteditable="true" style="border: 1px;">
					<textarea id="comment" rows="3" cols="20"
						style="width: 100%; resize: none;" maxlength="200">input your comment at here.</textarea>
				</div>
				<BR />
				<div style="margin-top: -27px;">
					<span id="addComment" class="label label-success pull-right">addComment</span>
				</div>


				<h2>Answers</h2>
				<BR />
				<s:iterator var="as" value="#request.question.answers" status="st">
					<tr class="danger">
						<div class="bs-example" data-example-id="media-list">
							<ul class="media-list">
								<li class="media">
									<div class="media-left">
										<a href="#"> <img class="media-object"
											data-src="holder.js/64x64" alt="64x64"
											src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iNjQiIGhlaWdodD0iNjQiIHZpZXdCb3g9IjAgMCA2NCA2NCIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+PCEtLQpTb3VyY2UgVVJMOiBob2xkZXIuanMvNjR4NjQKQ3JlYXRlZCB3aXRoIEhvbGRlci5qcyAyLjYuMC4KTGVhcm4gbW9yZSBhdCBodHRwOi8vaG9sZGVyanMuY29tCihjKSAyMDEyLTIwMTUgSXZhbiBNYWxvcGluc2t5IC0gaHR0cDovL2ltc2t5LmNvCi0tPjxkZWZzPjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI+PCFbQ0RBVEFbI2hvbGRlcl8xNTQ4YjA5ODA4NCB0ZXh0IHsgZmlsbDojQUFBQUFBO2ZvbnQtd2VpZ2h0OmJvbGQ7Zm9udC1mYW1pbHk6QXJpYWwsIEhlbHZldGljYSwgT3BlbiBTYW5zLCBzYW5zLXNlcmlmLCBtb25vc3BhY2U7Zm9udC1zaXplOjEwcHQgfSBdXT48L3N0eWxlPjwvZGVmcz48ZyBpZD0iaG9sZGVyXzE1NDhiMDk4MDg0Ij48cmVjdCB3aWR0aD0iNjQiIGhlaWdodD0iNjQiIGZpbGw9IiNFRUVFRUUiLz48Zz48dGV4dCB4PSIxMy40Njg3NSIgeT0iMzYuNSI+NjR4NjQ8L3RleHQ+PC9nPjwvZz48L3N2Zz4="
											data-holder-rendered="true"
											style="width: 64px; height: 64px;">
										</a>
									</div>
									<div class="media-body" >
										<h4 class="media-heading">
											<s:property value="#as.displayName" />
										</h4>
										<div id="answerBodyForEdit_<s:property value="#st.index" />">
											<s:property value="#as.body" escape="false" />
										</div>
										
						




										


										<div style="width: 100%; float: right;">
											<button type="button" class="btn btn-success btn-xs"
												style="float: right;" aria-label="Left Align"
												id="ForAnswerThumbDown" value="<s:property value="#as.id" />">
												<span class="glyphicon glyphicon glyphicon-thumbs-down"
													aria-hidden="true"></span>
											</button>
											
											<span class="label label-info" id="voteNumberForAnswer"
												style="float: right;"><s:property value="#as.vote" /></span>
											
											<button type="button" class="btn btn-success btn-xs"
												style="float: right;" aria-label="Left Align"
												id="ForAnswerThumbUp" value="<s:property value="#as.id" />">
												<span class="glyphicon glyphicon glyphicon-thumbs-up"
													aria-hidden="true"></span>
											</button>
											<s:if
											test="#as.ownerUserId==#session.user.id">
											<button type="button" class="btn btn-success btn-xs"
												style="float: right;" aria-label="Left Align"
												id="editAnswer_<s:property value="#st.index" />" value="<s:property value="#as.id" />">
												<span class="glyphicon glyphicon glyphicon-pencil"
													aria-hidden="true"></span>
											</button>
											
										</s:if>
										</div>
										
										
										








										<s:if
											test="#request.question.acceptedAnswerId==null || #request.question.acceptedAnswerId==''">
											<button type="button" class="btn btn-success btn-sm">
												<span class="glyphicon glyphicon-heart-empty-star"
													aria-hidden="true"></span> Accept
											</button>
										</s:if>
										<s:elseif test="#request.question.acceptedAnswerId==#as.id">
											<button type="button" class="btn btn-danger btn-sm">
												<span class="glyphicon glyphicon-heart " aria-hidden="true"></span>
												Accepted
											</button>
										</s:elseif>
										<!-- Nested media object -->
										<s:iterator var="ac" value="#as.coments" status="ast">
											<div class="media">
												<div class="media-left">
													<a href="#"> <img class="media-object"
														data-src="holder.js/64x64" alt="64x64"
														src="data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9InllcyI/PjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iNjQiIGhlaWdodD0iNjQiIHZpZXdCb3g9IjAgMCA2NCA2NCIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+PCEtLQpTb3VyY2UgVVJMOiBob2xkZXIuanMvNjR4NjQKQ3JlYXRlZCB3aXRoIEhvbGRlci5qcyAyLjYuMC4KTGVhcm4gbW9yZSBhdCBodHRwOi8vaG9sZGVyanMuY29tCihjKSAyMDEyLTIwMTUgSXZhbiBNYWxvcGluc2t5IC0gaHR0cDovL2ltc2t5LmNvCi0tPjxkZWZzPjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI+PCFbQ0RBVEFbI2hvbGRlcl8xNTQ4YjA5ODI5YiB0ZXh0IHsgZmlsbDojQUFBQUFBO2ZvbnQtd2VpZ2h0OmJvbGQ7Zm9udC1mYW1pbHk6QXJpYWwsIEhlbHZldGljYSwgT3BlbiBTYW5zLCBzYW5zLXNlcmlmLCBtb25vc3BhY2U7Zm9udC1zaXplOjEwcHQgfSBdXT48L3N0eWxlPjwvZGVmcz48ZyBpZD0iaG9sZGVyXzE1NDhiMDk4MjliIj48cmVjdCB3aWR0aD0iNjQiIGhlaWdodD0iNjQiIGZpbGw9IiNFRUVFRUUiLz48Zz48dGV4dCB4PSIxMy40Njg3NSIgeT0iMzYuNSI+NjR4NjQ8L3RleHQ+PC9nPjwvZz48L3N2Zz4="
														data-holder-rendered="true"
														style="width: 64px; height: 64px;">
													</a>
												</div>
												<div class="media-body">
													<h4 class="media-heading">
														<s:property value="#ac.displayName" />
													</h4>
													<p>
														<s:property value="#ac.text" escape="false" />
													</p>
												</div>
										</s:iterator>
									</div>
								</li>
							</ul>
						</div>
					</tr>
				</s:iterator>
				<table class="table">
					<tbody>
						<tr>
							<td>
								<h1>Write Answer</h1>
								<div class="btn-toolbar" data-role="editor-toolbar"
									data-target="#editor">


									<div class="btn-group">
										<a class="btn" data-edit="bold" title="Bold (Ctrl/Cmd+B)"><i
											class="icon-bold"></i></a> <a class="btn" data-edit="italic"
											title="Italic (Ctrl/Cmd+I)"><i class="icon-italic"></i></a>
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
									<input type="text" data-edit="inserttext" id="voiceBtn"
										x-webkit-speech="" />
								</div>

								<div id="editor" contenteditable="true">Write answer at here...keep cool</div>
								<div class="form-group">
									<form method="post"
										action="${pageContext.request.contextPath }/question/addAnswer.action" id="answerForm">
										<input type="text" class="hidden" id="answerBody"
											name="answer.body" /> <input type="text" class="hidden"
											name="question.id" value="${request.question.id }">
											<input type="text" class="hidden"
											name="answer.parentID" value="${request.question.id }">
										 <input type="text" class="hidden" id="answerId"
											name="answerId" value="0">
											<input type="text" name="returnPath" value="123" class="hidden"
								id="returnPath2" />
										<button class="btn btn-default drdropdown pull-left"
											id="submitAnswer">
											<span class="glyphicon glyphicon-edit">Submit Answer</span>
										</button>
										<button class="btn btn-default drdropdown pull-left hidden"
											id="updateAnswer">
											<span class="glyphicon glyphicon-edit">Update Answer</span>
										</button>
									</form>
									
										<button class="btn btn-default drdropdown pull-left hidden"
											id="undoUpdateAnswer">
											<span class="glyphicon glyphicon-edit">Undo</span>
										</button>
								</div>
							</td>

						</tr>


					</tbody>
				</table>
			</div>
			<div class="col-md-3 ">

				<div class="jumbotron">
					<h2>Find Why?</h2>
					<p>
						<a class="btn btn-primary btn-lg" href="ask.jsp" role="button">ask
							question</a>
					</p>
				</div>
				<div class="container-fluid">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed"
							data-toggle="collapse"
							data-target="#bs-example-navbar-collapse-4" aria-expanded="false">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="#">Help</a>
					</div>
					<div class="collapse navbar-collapse"
						id="bs-example-navbar-collapse-4">
						<p class="navbar-text" style="color: #286090;">If you want to
							add code, please add a symbol of &lt;code&gt; int
							a=0;&lt;/code&gt;</p>
						<p class="navbar-text" style="color: #286090;">comment can not
							add code</p>
						<p class="navbar-text" style="color: #286090;">Please follow
							the law</p>
					</div>
				</div>
				<table width="27%" class="table table-striped">

					<thead>
						<tr>
							<div class="btn-group ">

								<th id="smallGroup"></th>
							</div>

						</tr>
					</thead>
					<tbody id="smallGroupContent">

					</tbody>
				</table>

			</div>
		</div>

		<div class="row">
			<div class="col-md-12">

				<table class="table table-striped">

					<thead>
						<tr>
							<th>about our website</th>
							<th>coordination and cooperation</th>
							<th>useful links</th>
							<th>subscribe us</th>
							<th>others</th>

						</tr>
					</thead>
					<tbody>
						<tr>
							<td><a href="#">about us</a></td>
							<td><a href="#">contact us</a></td>
							<td><a href="#">google</a></td>
							<td><a href="#">Github</a></td>
							<td><a href="#">DUANG</a></td>
						</tr>
						<tr>

							<td><a href="#">join us</a></td>
							<td><a href="#">help center</a></td>
							<td><a href="#">University of Wollongong</a></td>
							<td><a href="#">Facebook</a></td>

						</tr>
						<tr>

							<td><a href="#">Prestige and authority</a></td>
							<td><a href="#">our partner</a></td>
							<td><a href="#">TeamLog</a></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>



		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">log in</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" role="form"
							action="${pageContext.request.contextPath }/user/login.action"
							method="post">
							<input type="text" name="returnPath" value="123" class="hidden"
								id="returnPath" />
							<div class="form-group">
								<label for="usertname" class="col-sm-2 control-label">name</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="username"
										name="user.displayName"
										placeholder="please input your  email ">
								</div>
							</div>
							<div class="form-group">
								<label for="inputPassword" class="col-sm-2 control-label">password</label>
								<div class="col-sm-10">
									<input type="password" class="form-control" id="inputPassword"
										name="user.password" placeholder="please input your password">
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<div id="showLoginMessage" style="margin-top: 5px;"></div>
									<div class="checkbox" style="margin-top: 20px;">
										<label> <input type="radio" name="remember" value="1">free
											login for 7 days
										</label>
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<button type="submit" id="login" value="1"
										class="btn btn-default">log in</button>
								</div>
							</div>
						</form>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">close
						</button>

					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>


		<div class="modal fade" id="registModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">sign up</h4>
					</div>
					<div class="modal-body">
						<form id="sub_signup" class="form-horizontal" role="form"
							action="${pageContext.request.contextPath }/user/signup.action"
							method="post">
							<s:token />
							<div class="form-group">
								<label for="usertname" class="col-sm-2 control-label">name</label>
								<div class="col-lg-5 ">
									<input type="text" class="form-control "
										name="user.displayName" id="susername"
										placeholder="input your username/email)">
								</div>
								<div id="ssusername" class="col-sm-5"></div>

							</div>
							<div class="form-group">
								<label for="inputPassword" class="col-sm-2 control-label">password</label>
								<div class="col-sm-5">
									<input type="password" name="user.password"
										class="form-control" id="spassword"
										placeholder="please input your password">
								</div>
								<div id="sspassword" class="col-sm-5"></div>
							</div>
							<div class="form-group">
								<label for="input2edPassword" class="col-sm-2 control-label">confirm
									password</label>
								<div class="col-sm-5">
									<input type="password" class="form-control"
										id="confirmpassword" placeholder="input your password again">
								</div>
								<div id="ssc" class="col-sm-5"></div>

							</div>
							<div class="form-group">
								<label for="input2edPassword" class="col-sm-2 control-label">Email
									:</label>
								<div class="col-sm-5">
									<input type="text" class="form-control" id="semail"
										name="user.email" placeholder="example@example.com">
								</div>
								<div id="ssemail" class="col-sm-5"></div>

							</div>

							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10">
									<button type="submit" id="tijiao_signup"
										class="btn btn-default">sign up</button>
								</div>
							</div>
						</form>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">close
						</button>

					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->







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
