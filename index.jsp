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
      var flag=1;
      $(document).ready(function(){
    	 
    	  $('#tbody').delegate('[id^="asd_"]', 'mouseover', function() {
				var value = $(this).children("input").val();
				 $(this).text(value);
			});
    	  
    	  $('#tbody').delegate('[id^="asd_"]', 'mouseout', function() {
    		  var value = $(this).text();
				var val = parseInt(value/1000);
				if(val>0){
					val = val+"k";
				}else{
					val = value;
				}
				$(this).html('<input class="badge" value="'+value+'" >'+val+'</input>');
			});
    	  
    	  $('#tbody').delegate('[id^="page_"]', 'click', function() {
    		  var pageNumber=$("#currentPage").val();
    		  if($(this).attr('id').indexOf("next")!=-1){
    			  pageNumber=parseInt(pageNumber)+1;
    		  };
    		  if($(this).attr('id').indexOf("last")!=-1){
    			  pageNumber=parseInt(pageNumber)-1;
    		  };
    		  var path = $("#path").val();
				$.ajax({  
		            url:path+'/question/all.action?currentPage='+pageNumber,  
		            type:'POST',  
		            data:"",  
		            dataType:'json',  
		            success:function (data) {
		            	$("#tbody").html("");
		            	$(data.questions).each(function (i, value) {  
		            		var valv = parseInt(value.viewCount/1000);
		    				if(valv>0){
		    					valv = valv+"k";
		    				}else{
		    					valv = value.viewCount;
		    				}
		    				
		    				var vala = parseInt(value.answerCount/1000);
		    				if(vala>0){
		    					vala = vala+"k";
		    				}else{
		    					vala =value.answerCount;
		    				}
		    				
		    				var valc = parseInt(value.commentCount/1000);
		    				if(valc>0){
		    					valc = valc+"k";
		    				}else{
		    					valc = value.commentCount;
		    				}
		                    $("#tbody").append("<tr>"+
		    		                "<td><span class='badge ' id='asd_"+i+"v'> <input class='badge' value='"+value.viewCount+"'>"+valv+"</input></span></td>"+
		    		                "<td><span class='badge ' id='asd_"+i+"a'> <input class='badge' value='"+value.answerCount+"'>"+vala+"</input></span></td>"+
		    		                "<td><span class='badge ' id='asd_"+i+"c'> <input class='badge' value='"+value.commentCount+"'>"+valc+"</input></span></td>"+
		    		                
		    		                "<td><a href='"+path+"/question/scan.action?question.id="+value.id+"'>"+value.title+"</a></td>"+
		    		             "</tr>");  
		                });  
		                var htmlValue = "<tr>"+
		                "<td><span class='badge '> <input class='badge' ></input></span></td>"+
		                "<td><span class='badge ' > <input class='badge' ></input></span></td>"+
		                "<td><span class='badge ' > <input class='badge' ></input></span></td>"+
		                "<td>" ;
		            	htmlValue += "<button id='page_next' type='button' class='btn btn-default  pull-right'>Next</button>";
		            		if(pageNumber!=1){
			            		htmlValue +="<button id='page_last' type='button' class='btn btn-default  pull-right'>Last</button>";
			            	 }
		            		htmlValue += "</td></tr>";
		            	$("#tbody").append(htmlValue);
		            	$("#currentPage").val(pageNumber);
		            }  
		            
		        }); 
			});
    	 
    	   $('#smallGroup').delegate('[id^="fun_"]', 'click', function() {
    		   var path = $("#path").val();
    		   if(this.value == 1){
    			   $("#smallGroup").html("<button type='button' class='btn  btn-info pull-left  ' id='fun_hot' value='1' >Hot</button>"+   
	             	"<button type='button' class='btn btn-default  pull-left' id='fun_recommend' value='2'>Recommend</button>");
    			   $.ajax({  
   		            url:path+'/question/hot.action',  
   		            type:'POST',  
   		            data:"",  
   		            dataType:'json',  
   		            success:function (data) {
   		            	$("#smallGroupContent").html("");
   		            	$(data.questions).each(function (i, value) {  
   		            		$("#smallGroupContent").append("<tr>"+
   		    		                "<td><a href='"+path+"/question/scan.action?question.id="+value.id+"'>"+value.title+"</a></td>"+
   		    		             "</tr>"); 
   		            		
   		            	
   		            	});  
   		            } 
   		        });
    		   }else{
    			  $("#smallGroup").html("<button type='button' class='btn btn-info  pull-left' id='fun_recommend' value='2'>Recommend</button>"+"<button type='button' class='btn  btn-default pull-left  ' id='fun_hot' value='1' >Hot</button><span id='fun_refresh'  class='glyphicon glyphicon-refresh pull-right' aria-hidden='true'></span>");  
    	          
    			  $.ajax({  
  		            url:path+'/question/questionsRecommend.action',  
  		            type:'POST',  
  		            data:"",  
  		            dataType:'json',  
  		            success:function (data) {
  		            	$("#smallGroupContent").html("");
  		            	var htmlValue="smallGroupContent";
  		            	$(data.questions).each(function (i, value) {  
  		            		$("#smallGroupContent").append("<tr>"+
  		    		                "<td><a href='"+path+"/question/scan.action?question.id="+value.id+"'>"+value.title+"</a></td>"+
  		    		             "</tr>"); 
  		            		
  		            	
  		            	});  
  		            } 
  		        });
    		  }

			}); 
    	  
			$(function(){
				$('[data-toggle="popover"]').popover();
			});
			
			$("#susername").blur(function(){
				var val = $(this).val();
				if(val=="" || val==null){
				}else{
					if(val.length<5 || val.length>12){
						$("#ssusername").html(" <spane class='alert alert-danger' role='alert'>Legth should belong 5 - 12</span>");
					}else{
						$("#ssusername").html(" <spane class='alert alert-success' role='alert'>You can use this displayname</span>");
					}
				}
				});
			
			$("#spassword").blur(function(){
				var val = $(this).val();
				if(val=="" || val==null){
				}else{
					if(val.length<5 || val.length>12){
						$("#sspassword").html(" <spane class='alert alert-danger' role='alert'>Legth should belong 5 - 12</span>");
					}else{
						$("#sspassword").html(" <spane class='alert alert-success' role='alert'></span>");;
					}
				}
			});
			
			$("#confirmpassword").blur(function(){
				var cval = $(this).val();
				var val = $("#spassword").val();
				if(cval=="" || cval==null){
				}else{
					if(val!=cval){
						$("#ssc").html(" <spane class='alert alert-danger' role='alert'>Password were not same</span>");
					}else{
						$("#ssc").html(" <spane class='alert alert-success' role='alert'></span>");
					}
				}
			});
			
			$("#semail").blur(function(){
				var val = $(this).val();
				if(val=="" || val==null){
				}else{
					if(!val.match(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)){
						$("#ssemail").html(" <spane class='alert alert-danger' role='alert'>Mali format is wrong</span>");
					}else{
						
					}
				}
				var path = $("#path").val();
				$.ajax({  
					contentType:"UTF-8",
		            url:path+'/user/checkuser.action?user.email='+val,  
		            type:'POST',  
		            data:"", 
		            dataType:'json',  
		            success:function (data) {
		            	if(data[0].id!=0){
		            		$("#ssemail").html(" <spane class='alert alert-danger' role='alert'>Exist email</span>");
		            	}else{
		            		if(!val.match(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)){
								$("#ssemail").html(" <spane class='alert alert-danger' role='alert'>Mali format is wrong</span>");
							}else{
								$("#ssemail").html(" <spane class='alert alert-success' role='alert'>You can use this email</span>");
							}
		            		
		            	}
		            }  
		            
		        });
			});
			
			$(":submit[id^='tijiao_']").click(function(check){ 
				var temp=0;
				if($("#susername").val()=="" || $("#susername").val()==null){
					temp=1;
					$("#ssusername").html(" <spane class='alert alert-danger' role='alert'>DisplayName shouldn't be empty</span>");
				}else{
					if($("#susername").val().length<5 || $("#susername").val().length>12){
						temp=1;
						$("#ssusername").html(" <spane class='alert alert-danger' role='alert'>Legth should belong 5 - 12</span>");
					}
				}
				if($("#spassword").val()=="" || $("#spassword").val()==null){
					if(temp==0){
						temp=2;
					}
					$("#sspassword").html(" <spane class='alert alert-danger' role='alert'>Password shouldn't be empty</span>");
				}else{
					if($("#spassword").val().length<5 || $("#spassword").val().length>12){
						if(temp==0){
							temp=2;
						}
						$("#sspassword").html(" <spane class='alert alert-danger' role='alert'>Legth should belong 5 - 12</span>");
					}else{
					}
				}
				if($("#confirmpassword").val()!=$("#spassword").val()==null){
					if(temp==0){
						temp=3;
					}
					$("#ssc").html(" <spane class='alert alert-danger' role='alert'>It's different with password</span>");
				}
				if($("#semail").val()=="" || $("#semail").val()==null){
					if(temp==0){
						temp=4;
					};
					$("#ssemail").html(" <spane class='alert alert-danger' role='alert'>Mali shouldn't be empty</span>");
				}else{
					if(!$("#semail").val().match(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/)){
						if(temp==0){
							temp=4;
						}
						$("#ssemail").html(" <spane class='alert alert-danger' role='alert'>Mali format is wrong</span>");
					}
				}
				if(temp!=0){
					if(temp==1){
						$("#susername").focus(); 
					}
					else if(temp==2){
						$("#spassword").focus(); 
					}
					else if(temp==3){
						$("#confirmpassword").focus(); 
					}
					else if(temp==4){
						$("#semail").focus(); 
					}
					return false;
					 
				}else{

					if($("#ssemail").html().indexOf("success")==-1){
						$("#ssemail").focus(); 
						return false;
					}
					if($("#ssusername").html().indexOf("success")==-1){
						$("#susername").focus();
						return false;
					}
				}
				return true;
				/*  alert(1);
				alert($("#path").val()+"/user/signup.action?user.displayName="+$("#susername").val()+"&user.password="+$("#spassword").val()+"&user.email="+$("#semail").val());
				window.location.href=$("#path").val()+"/user/signup.action?user.displayName="+$("#susername").val()+"&user.password="+$("#spassword").val()+"&user.email="+$("#semail").val();		
		    	*/
			}); 
			
			$(":submit[id^='login']").click(function(check){
				var temp=0;
				var temp2=0;
				if($("#username").val()=="" || $("#username").val()==null){
					temp=1;
					 $("#showLoginMessage").html(" <spane class='alert alert-danger' role='alert'>Username is empty</span>"); 
				}
				
				if($("#inputPassword").val()=="" || $("#inputPassword").val()==null){
					if(temp==0){
						temp=2;
					}
					$("#showLoginMessage").html(" <spane class='alert alert-danger' role='alert'>Password is empty</span>");
				}
				if(temp!=0){
					if(temp==1){
						$("#susername").focus(); 
					}
					else if(temp==2){
						$("#spassword").focus(); 
					}
					return false;	 
				}else{
					var path = $("#path").val();
					var name = $("#username").val();
					var password = $("#inputPassword").val();
					$.ajax({  
						contentType:"UTF-8",
			            url:path+'/user/checkuser.action?user.displayName='+name+'&user.email='+name+'&user.password='+password,  
			            type:'POST',  
			            data:"", 
			            dataType:'json',  
			            success:function (data) {
			            	if(data[0].id!=0){
			            		return true;
			            		
			            	}else{
			            		$("#showLoginMessage").html(" <spane class='alert alert-danger' role='alert'>Username or password is wrong!!!</span>");
			            		return false;
			            	}
			            }  
			            
			        });
				}
		    }); 
			
			$(function(){
				 $("#smallGroup").html("<button type='button' class='btn  btn-info pull-left  ' id='fun_hot' value='1' >Hot</button>"+   
	             	"<button type='button' class='btn btn-default  pull-left' id='fun_recommend' value='2'>Recommend</button>");
				var path = $("#path").val();
				$.ajax({  
		            url:path+'/question/all.action?currentPage=0',  
		            type:'POST',  
		            data:"",  
		            dataType:'json',  
		            success:function (data) {
		            	$(data.questions).each(function (i, value) {  
		            		var valv = parseInt(value.viewCount/1000);
		    				if(valv>0){
		    					valv = valv+"k";
		    				}else{
		    					valv = value.viewCount;
		    				}
		    				var vala = parseInt(value.answerCount/1000);
		    				if(vala>0){
		    					vala = vala+"k";
		    				}else{
		    					vala =value.answerCount;
		    				}
		    				var valc = parseInt(value.commentCount/1000);
		    				if(valc>0){
		    					valc = valc+"k";
		    				}else{
		    					valc = value.commentCount;
		    				}
		                    $("#tbody").append("<tr>"+
		    		                "<td><span class='badge ' id='asd_"+i+"v'> <input class='badge' value='"+value.viewCount+"'>"+valv+"</input></span></td>"+
		    		                "<td><span class='badge ' id='asd_"+i+"a'> <input class='badge' value='"+value.answerCount+"'>"+vala+"</input></span></td>"+
		    		                "<td><span class='badge ' id='asd_"+i+"c'> <input class='badge' value='"+value.commentCount+"'>"+valc+"</input></span></td>"+
		    		                
		    		                "<td><a href='"+path+"/question/scan.action?question.id="+value.id+"'>"+value.title+"</a></td>"+
		    		             "</tr>");  
		                });  
		                var htmlValue = "<tr>"+
		                "<td><span class='badge '> <input class='badge' ></input></span></td>"+
		                "<td><span class='badge ' > <input class='badge' ></input></span></td>"+
		                "<td><span class='badge ' > <input class='badge' ></input></span></td>"+
		                "<td>" ;
		            	if($("#currentPage").val()!=1){
		            		htmlValue +="<button id='page_last' type='button' class='btn btn-default  pull-left'>Last</button>";
		            	 } 
		            	htmlValue += "<button id='page_next' type='button' class='btn btn-default  pull-right'>Next</button></td></tr>";
		            	$("#tbody").append(htmlValue);
		            }  
		            
		        }); 
				$.ajax({  
		            url:path+'/target/hotTargets.action',  
		            type:'POST',  
		            data:"",  
		            dataType:'json',  
		            success:function (data) {
		            	var htmlValue="hotTargets";
		            	$(data.targets).each(function (i, value) {  
		            		$("#hotTargets").append("<button type='button' class='btn btn-default'>"+value.name+"</button>"); 
		            	});  
		            } 
		        });
				$.ajax({  
		            url:path+'/question/hot.action',  
		            type:'POST',  
		            data:"",  
		            dataType:'json',  
		            success:function (data) {
		            	$(data.questions).each(function (i, value) {  
		            		$("#smallGroupContent").append("<tr>"+
		    		                "<td><a href='"+path+"/question/scan.action?question.id="+value.id+"'>"+value.title+"</a></td>"+
		    		             "</tr>"); 
		            	});  
		            } 
		        });
				if($("#firstTime").val()!=2){
				$.ajax({  
		            url:path+'/user/autoLogin.action',
		            type:'POST',  
		            data:"",  
		            dataType:'json',  
		            success:function (data) {
		            	var hemlvar="";
		            	hemlvar+="<li class='active'><a href='#'>LOGO</a></li>";
		            	hemlvar+="<form class='form-search navbar-left drdropdown pull-right'>";
		            	hemlvar+="<input class='input-medium search-query' type='text' placeholder='Search  U Want'/> <button type='submit' class='btn btn-primary' id='but1'><span class='glyphicon glyphicon-search'></span>SEARCH</button>";
		            	hemlvar+="  </form>";
		            	hemlvar+="<li class='dropdown pull-right'>";
		            	hemlvar+="<a class='dropdown-toggle' data-toggle='dropdown' href='#'>";
		            	hemlvar+=data.displayName+" <span class='caret '></span><span class='badge '>2</span>";
		            	hemlvar+="</a>";
		            	hemlvar+="<ul class='dropdown-menu'>";
		            	hemlvar+="<li><a href='#'>MY SETTING</a></li>";
		            	hemlvar+="<li><a href='#'>MY Q&A</a></li>";
		            	hemlvar+="<li><a href='#'>Regist</a></li>";
		            	hemlvar+="<li class='divider'></li>";
		            	hemlvar+="<li><a href="+path+"/user/logout.action>EXIT</a></li>";
		            	hemlvar+="</ul>";
		            	hemlvar+="</li>";
		                    
		            	$("#headnav").html(hemlvar);
		            	
		            }  
		            
		        }); 
				}
			});
			
			
		});
	  </script>
<body>
	<input id="currentPage" type="hidden" value="1">
	<input id="firstTime" type="hidden" value="${time}">
	<input id="path" type="hidden"
		value="${pageContext.request.contextPath }" />
	<div class="container">
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
			<div class="col-md-12 btn-group-xs">
				<div class="btn-group" id="hotTargets"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-8">
				<table width="27%" class="table table-striped">
					<thead>
						<tr>
							<th>Views</th>
							<th>Answers</th>
							<th>Comments</th>
							<th>Title</th>
						</tr>
					</thead>

					<tbody id="tbody">

					</tbody>
				</table>
			</div>
			<div class="col-md-3 ">
				<div class="jumbotron">
					<h1>Find Why?</h1>
					<p>
						<a class="btn btn-primary btn-lg" href="#" role="button">ask
							question</a>
					</p>
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
						<div class="form-group">
							<label for="usertname" class="col-sm-2 control-label">name</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="username"
									name="user.displayName"
									placeholder="please input your displayname or email ">
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
								<input type="text" class="form-control " name="user.displayName"
									id="susername" placeholder="input your username/email)">
							</div>
							<div id="ssusername" class="col-sm-5"></div>
						</div>
						<div class="form-group">
							<label for="inputPassword" class="col-sm-2 control-label">password</label>
							<div class="col-sm-5">
								<input type="password" name="user.password" class="form-control"
									id="spassword" placeholder="please input your password">
							</div>
							<div id="sspassword" class="col-sm-5"></div>
						</div>
						<div class="form-group">
							<label for="input2edPassword" class="col-sm-2 control-label">confirm
								password</label>
							<div class="col-sm-5">
								<input type="password" class="form-control" id="confirmpassword"
									placeholder="input your password again">
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
								<button type="submit" id="tijiao_signup" class="btn btn-default">sign
									up</button>
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

</html>
