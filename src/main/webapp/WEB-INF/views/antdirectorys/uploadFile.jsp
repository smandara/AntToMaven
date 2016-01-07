<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<div xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:spring="http://www.springframework.org/tags/form" version="2.0">
	<jsp:directive.page import="com.infy.utility.BrowseUtility" />
	<jsp:directive.page
		import="org.springframework.context.annotation.Import" />
	<jsp:directive.page contentType="text/html;charset=UTF-8" />

	<div>
		<form action="${form_url}?upload" method="post"
			enctype="multipart/form-data">
			<table>
				<tr>
					<td>Please Upload the Ant Project Folder Here (.zip format)</td>
					<td><input type="file" name="file" /></td>
				</tr>
				
			</table>
			<br/>		
				<input type="submit" value="upload" style="width: 150px; margin-left: 522px" />
		</form>
	</div>