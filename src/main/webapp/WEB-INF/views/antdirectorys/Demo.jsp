<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<div xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:spring="http://www.springframework.org/tags/form" version="2.0">
	<jsp:directive.page import="com.infy.utility.BrowseUtility" />
	<jsp:directive.page
		import="org.springframework.context.annotation.Import" />
	<jsp:directive.page contentType="text/html;charset=UTF-8" />
	<center>
		<div style="width: 700px; heigth: 360px; margin-top: 10px;">
<script  src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.js"></script>

<script type="text/javascript">
// Fork for IE 5.5

if(window.navigator.appname.indexOf("IE")!= -1) {
   document.write("Internet Explorer 5.5")
   alert("IE")
   <embed type="" src="./videos/ANTtoMAVENDemo.mp4" align="middle"
 		autoplay="false" autostart="false" title="Demo" height="350px"
 			width="510px" style=""> }
// Fork for IE 6.0
if(window.navigator.appVersion.indexOf("IE 6.0")!= -1) {
   document.write("Internet Explorer 6.0") }
</script>
	
		
<%
String browser=request.getHeader("user-agent");
 if(browser != null ){
    	
        if(browser.indexOf("Chrome")!=-1)
        {

        	%>
        
        	<video controls="" style="align:center; width: 700px; height: 360px;"
				poster="./images/demo.png">
				<source src="./videos/ANTtoMAVENDemo.mp4"
					type="video/mp4;codecs=avc1.42E01E, mp4a.40.2">
			</video>
        	  
     <%      
    }
	
	
   else  if(browser.indexOf("Trident")!=-1)
       {
        
        	%>
        	
        		<embed type="" src="./videos/ANTtoMAVENDemo.mp4" align="middle"
              		autoplay="false" autostart="false" title="Demo" height="400px"
              			width="700px" style="">  
     <%   }
    else{%>
    
       
             <script> 
             
           alert("Please use Google Chrome or IE to play the video");

        	document.location.href = "/AntToMaven"; 
        	</script>
      <%
     }
} %>
	


</div>

	</center>
	
	</div>	
