<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<div xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:spring="http://www.springframework.org/tags/form" version="2.0">
	<jsp:directive.page import="com.infy.utility.BrowseUtility" />
	<jsp:directive.page
		import="org.springframework.context.annotation.Import" />
	<jsp:directive.page contentType="text/html;charset=UTF-8" />
<a href="/AntToMaven" style="margin-left: 950px">Home</a>
	<center>
		<div style="width: 640px; heigth: 360px; margin-top: 10px;">
		
		
<%
String browser=request.getHeader("user-agent");


 if(browser != null ){
    	
        if(browser.indexOf("Chrome")!=-1)
        {

        	%>
        	<video controls="" style="align:center; width: 640px; height: 360px;"
				poster="./images/demo.png">
				<source src="./videos/ANTtoMAVENDemo.mp4"
					type="video/mp4;codecs=avc1.42E01E, mp4a.40.2">
			</video>
        	  
     <%      
    }
        else  if(browser.indexOf("Mozilla")!=-1)
        {
        	%> <script> 
        	var ask = window.confirm("Please use Google Chrome or IE to play the video");
        	if(ask)
        	document.location.href = "/AntToMaven";
        	</script>
     <%   }
    else{%>
    	<embed type="" src="./videos/ANTtoMAVENDemo.mp4" align="middle"
              		autoplay="false" autostart="false" title="Demo" height="350px"
              			width="510px" style="">
     <%
      
     }
} %>
	


</div>

	</center>