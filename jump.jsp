<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 引入struts2标签 -->
<%@ taglib uri="/struts-tags"  prefix="s" %>
<!DOCTYPE html>
<html>
   <head>
      <title>FQA</title>
       <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <script src="${pageContext.request.contextPath }/js/jquery.js"></script>
      <script type="text/javascript">
         $().ready(function(){
        	 
        	 var path=$("#path").val();
        	 if(""==path){
        		 path="/FQA/index.jsp";
        	 }
   		    window.location.href=path;
         });
	  </script>
   <body id="body">
   <input id="path" value="${returnPath}"/>
   </body>

</html>
