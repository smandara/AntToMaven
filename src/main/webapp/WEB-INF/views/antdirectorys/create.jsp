<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<div xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:jsp="http://java.sun.com/JSP/Page"
	xmlns:spring="http://www.springframework.org/tags/form" version="2.0">
	<jsp:directive.page import="com.infy.utility.BrowseUtility" />
	<jsp:directive.page
		import="org.springframework.context.annotation.Import" />
	<jsp:directive.page contentType="text/html;charset=UTF-8" />
<script type="text/javascript" src="../jquery-1.11.3.js"></script>
	<script type="text/javascript">
		
	function showTest() {
			var renderValSrc = document.getElementById(
					"com_infy_entities_AntDirectory_configSRC").getAttribute(
					"render");
			if (renderValSrc) {
				document
						.getElementById("com_infy_entities_AntDirectory_configTestpath").style.display = 'block';
				document.getElementById("test").style.display = 'block';
				

			}
		}
		function showWeb() {
			var renderVal = document.getElementById(
					"com_infy_entities_AntDirectory_configTestpath")
					.getAttribute("render");
			if (renderVal) {
				document
						.getElementById("com_infy_entities_AntDirectory_configWebSrc").style.display = 'block';
				document.getElementById("Web").style.display = 'block';

			}
		}
		function showLib() {
			var renderVal = document.getElementById(
					"com_infy_entities_AntDirectory_configWebSrc")
					.getAttribute("render");
			if (renderVal) {
				document
						.getElementById("com_infy_entities_AntDirectory_configLib").style.display = 'block';
				document.getElementById("lib").style.display = 'block';

			}
		}
		
	
	</script>

	<br/><br/>
	<form:form modelAttribute="antDirectory" path="/antdirectorys"
		method="POST" action="${form_url}?create">
		<table border="0px	">
			<tr border="0">
			
				<form:input id="com_infy_entities_AntDirectory_folderPath"
						required="true" render="false" path="folderPath"
					 readonly="true"  style="display:none"	/>
		</tr>
			<tr border="0">
				<td>
				<label id="source" >Source folder with reference to ANT Project path&nbsp;<FONT color="red">*</FONT>
						<br/>(For multiple source folders specify the folders seperated by comma Ex: src,src2)
						</label>  </td>
				<td><form:input id="com_infy_entities_AntDirectory_configSRC"
						render="true" required="true" path="configSRC"
						 onchange="showWeb();" ></form:input> </td>
					
			
			</tr>
				
			<tr border="0"> <td border="0"></td><td border="0"></td></tr>
			<tr border="0">
				<td><label id="Web" style="display: none">WebContent
						Folder with reference to ANT Project  path &nbsp;<FONT color="red">*</FONT> </label></td>
				<td><form:input
						id="com_infy_entities_AntDirectory_configWebSrc" required="true"
						render="true" path="configWebSrc" style="display:none"
						onchange="showLib();"></form:input></td>
		
			</tr>
			<tr border="0">
				<td><label id="lib" style="display: none">Lib 
						Folder with reference to ANT Project <br/> path &nbsp; <FONT color="red">*</FONT></label> </td>
				<td><form:input id="com_infy_entities_AntDirectory_configLib"
						required="true" path="configLib" style="display:none" onchange="showTest();"></form:input></td>
			
			</tr>
			
			<tr border="0">
				<td><label id="test" style="display: none">Test case
						Folder with reference to ANT Project  path </label></td>

				<td><form:input
						id="com_infy_entities_AntDirectory_configTestpath" 
						render="true" path="configTestpath" style="display:none"></form:input></td>
			
			</tr>

		</table>
		<input type="submit" value="Next"  style="width: 90px;height: 30px;background-color:#1F497D; color:white;font-size:17px; " />
	</form:form>


</div>
