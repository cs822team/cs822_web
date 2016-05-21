<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 引入struts2标签 -->
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

<script type="text/javascript">
	$(document).ready(function() {
		 $('#matchTargets').delegate('[id^="btn_"]', 'click', function() {
			 var tags = $("#tags").val();
				if(tags==""){
					tags +=$(this).val();
				}else{
					if($(this).hasClass("1")){
						
					}else{
						$(this).addClass("1");
						if($('#tags').hasClass("1")){
							var s = tags.lastIndexOf(",");
							if(s==-1){
								tags="";
							}else{
								tags = tags.substring(0,s);
							}
							$('#tags').removeClass("1");
						}
						if(tags.length!=0){
							tags += ",";
						}
						tags += $(this).val();
					}
				}
				
				$("#tags").val(tags);
				$("#tags").heml(tags);
		 });
		 $('#tags').keyup(function(){
			 var path = $("#path").val();
			 $(this).addClass("1");
			 $.ajax({  
		            url:path+'/target/matchTargets.action?tags='+$("#tags").val(),  
		            type:'POST',  
		            data:"",  
		            dataType:'json',  
		            success:function (data) {
		            	$("#matchTargets").html(""); 
		            	$(data.targets).each(function (i, value) {
		            		var clazz;
		            		if(i%6==0){
		            			clazz="default";
		            		}
		            		if(i%6==1){
		            			clazz="primary";
		            		}
		            		if(i%6==2){
		            			clazz="info";
		            		}
		            		if(i%6==3){
		            			clazz="success";
		            		}
		            		if(i%6==4){
		            			clazz="warning";
		            		}
		            		if(i%6==5){
		            			clazz="danger";
		            		}
		            		var htmlValue="<div class=\"btn-group\" style=\"height: 50px; margin-left: 10px;\">";
		            		htmlValue += "<button type=\"button\" class=\"btn btn-"+clazz+" \" value=\""+value.name+"\" id=\"btn_"+i+"\">"+value.name+"</button></div>";         
		            		$("#matchTargets").append(htmlValue); 
		            	}); 
		            } 
		 	});
		 });
		$(function(){
			var path = $("#path").val();
			$.ajax({  
	            url:path+'/target/matchTargets.action',  
	            type:'POST',  
	            data:"",  
	            dataType:'json',  
	            success:function (data) {
	            	$(data.targets).each(function (i, value) {
	            		var clazz;
	            		if(i%6==0){
	            			clazz="default";
	            		}
	            		if(i%6==1){
	            			clazz="primary";
	            		}
	            		if(i%6==2){
	            			clazz="info";
	            		}
	            		if(i%6==3){
	            			clazz="success";
	            		}
	            		if(i%6==4){
	            			clazz="warning";
	            		}
	            		if(i%6==5){
	            			clazz="danger";
	            		}
	            		var htmlValue="<div class=\"btn-group\" style=\"height: 50px; margin-left: 10px;\">";
	            		htmlValue += "<button type=\"button\" class=\"btn btn-"+clazz+" \" value=\""+value.name+"\" id=\"btn_"+i+"\">"+value.name+"</button></div>";         
	            		$("#matchTargets").append(htmlValue); 
	            	}); 
	            } 
	        });
		});
	});
</script>
</head>
<body>
<input id="currentPage" type="hidden" value="1">
<input id="path" type="hidden"
		value="${pageContext.request.contextPath }" />
	<div class="container" >
		<div class="row">
			<div class="col-md-12">
				<ul class="nav nav-pills">
					<li class="active"><a href="#">LOGO</a></li>





					<li class="drdropdown pull-right"><a href="#"
						data-toggle="modal" data-target="#myModal">log in</a></li>
					<li class="drdropdown pull-right"><a href="#"
						data-toggle="modal" data-target="#registModal">sign up</a></li>
					<li class="drdropdown pull-right"><a href="#"> help </a></li>


					<li class="dropdown pull-right"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#"> ACCOUNT <span class="caret "></span><span
							class="badge ">2</span>
					</a>
						<ul class="dropdown-menu">
							<li><a href="#">MY SETTING</a></li>
							<li><a href="#">MY Q&A</a></li>
							<li><a href="#">Regist</a></li>
							<li class="divider"></li>
							<li><a href="#">EXIT</a></li>
						</ul></li>

				</ul>
			</div>
		</div>
		<br />


		<div class="row">
			<div class="col-sm-6 col-md-12">
				<form action="${pageContext.request.contextPath }/question/search.action" method="post" id="searchForm">
				<div class="input-group input-group-lg">
					<span class="input-group-addon" id="sizing-addon1">Content</span> <input
						type="text" class="form-control" placeholder="Input your content" name="question.body"
						aria-describedby="sizing-addon1">
				</div>
				<BR />
				<div class="input-group input-group-lg">
					<span class="input-group-addon" id="sizing-addon1">Tag</span> <input
						type="text" class="form-control" placeholder="Input Tags" name="question.tags" 
						aria-describedby="sizing-addon1" id="tags">
				</div>
				<button class="input-group input-group-lg" id="search" type="submit">
					<span class="input-group-addon glyphicon glyphicon-search" id="sizing-addon1">search</span> 
				</button>
				</form>
				<BR />

				<!-- Single button -->
				<div class="btn-group" ></div>
				
				
				
				
				
				
				<div class="bs-example" data-example-id="single-button-dropdown" id="matchTargets">
					<!-- <div class="btn-group" style="height: 50px; margin-left: 10px;">
						<button type="button" class="btn btn-default " value="java"
							id="btn_1">java</button>
					</div>
					<div class="btn-group" style="height: 50px; margin-left: 10px;">
						<button type="button" class="btn btn-primary " value="css" id="btn_2">css
						</button>
					</div>
					<div class="btn-group" style="height: 50px; margin-left: 10px;">
						<button type="button" class="btn btn-success " value="c/c++" id="btn_3">c/c++</button>
					</div>
					<div class="btn-group" style="height: 50px; margin-left: 10px;">
						<button type="button" class="btn btn-info ">Info</button>
					</div>
					<div class="btn-group" style="height: 50px; margin-left: 10px;">
						<button type="button" class="btn btn-warning ">Warning</button>
					</div>
					<div class="btn-group" style="height: 50px; margin-left: 10px;">
						<button type="button" class="btn btn-danger ">Danger</button>
					</div>
					<div class="btn-group" style="height: 50px;">
						<button type="button" class="btn btn-default ">Default</button>
					</div>
					<div class="btn-group" style="height: 50px;">
						<button type="button" class="btn btn-primary ">Primary</button>
					</div>
					<div class="btn-group" style="height: 50px;">
						<button type="button" class="btn btn-success ">Success</button>
					</div>
					<div class="btn-group" style="height: 50px;">
						<button type="button" class="btn btn-info ">Info</button>
					</div>
					<div class="btn-group" style="height: 50px;">
						<button type="button" class="btn btn-warning ">Warning</button>
					</div>
					<div class="btn-group" style="height: 50px;">
						<button type="button" class="btn btn-danger ">Danger</button>
					</div>
					<div class="btn-group" style="height: 50px;">
						<button type="button" class="btn btn-default ">Default</button>
					</div>
					<div class="btn-group" style="height: 50px;">
						<button type="button" class="btn btn-primary ">Primary</button>
					</div>
					<div class="btn-group" style="height: 50px;">
						<button type="button" class="btn btn-primary ">Primary</button>
					</div>
					<div class="btn-group" style="height: 50px;">
						<button type="button" class="btn btn-success ">Success</button>
					</div>
					<div class="btn-group" style="height: 50px;">
						<button type="button" class="btn btn-info ">Info</button>
					</div>
					<div class="btn-group" style="height: 50px;">
						<button type="button" class="btn btn-warning ">Warning</button>
					</div>
					<div class="btn-group" style="height: 50px;">
						<button type="button" class="btn btn-danger ">Danger</button>
					</div>
					<div class="btn-group" style="height: 50px;">
						<button type="button" class="btn btn-default ">Default</button>
					</div>
					<div class="btn-group" style="height: 50px;">
						<button type="button" class="btn btn-primary ">Primary</button>
					</div> -->
					<!-- /btn-group -->
				</div>
				<BR /> <BR /> <BR />
			</div>
		</div>
		<div class="row">
			<s:iterator var="q" value="#request.questions" status="st">
				<div class="col-sm-6 col-md-12">
				<div class="thumbnail">
					<div class="caption">
						<div class="media-body">
							<h4 class="media-heading"><a href="${pageContext.request.contextPath }/question/scan.action?question.id=<s:property value="#q.id" />"><s:property value="#q.title" /></a></h4>
							<p><s:property value="#q.body" escape="false" /></p>
						</div>
					</div>
				</div>
			</div>
			</s:iterator>
			
			

			<nav>
				<ul class="pager">
					<li class="previous disabled"><a href="#"><span
							aria-hidden="true">&larr;</span> Older</a></li>
					<li class="next"><a href="#">Newer <span
							aria-hidden="true">&rarr;</span></a></li>
				</ul>
			</nav>

		</div>
</body>
</html>
