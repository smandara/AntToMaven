// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.infy.controllers;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.io.FileUtils;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

import com.infy.entities.AntDirectory;
import com.infy.processor.Convertor;
import com.infy.utility.FileUtility;
import com.infy.utility.ZipUtility;

privileged aspect AntDirectoryController_Roo_Controller {
	
	private static final String UPLOAD_DIRECTORY = "C:/zip";
	private static final String UNZIP_DIRECTORY = "C:/zip/unzip/";
	private static String download_dir =null;
	

	@RequestMapping(method = RequestMethod.POST, params="create", produces = "text/html")
	public String AntDirectoryController.create(@Valid AntDirectory antDirectory, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
		if (bindingResult.hasErrors()) {
			populateEditForm(uiModel, antDirectory);
			return "antdirectorys/create";
		}
		System.out.println("Ant folder path :: "+antDirectory.getFolderPath());
		System.out.println("Ant folder src :: "+antDirectory.getConfigSRC());
		System.out.println("Ant folder artifact id :: "+antDirectory.getArtifactId());
		System.out.println("Ant folder revision id :: "+antDirectory.getGroupId());
		System.out.println("Ant folder path :: "+antDirectory.getVersionId());
		System.out.println("Ant folder path :: "+antDirectory.getConfigLib());
		System.out.println("Ant folder path :: "+antDirectory.getConfigTestpath());
		System.out.println("Ant folder path :: "+antDirectory.getConfigWebSrc());


		uiModel.asMap().clear();
		antDirectory.persist();
		return "redirect:/antdirectorys/" + encodeUrlPathSegment(antDirectory.getId().toString(), httpServletRequest);
	}

	@RequestMapping(params = "form", produces = "text/html")
	public String AntDirectoryController.uploadForm(Model uiModel) {
		return "antdirectorys/upload";
	}

		
	@RequestMapping(value = "/{id}", produces = "text/html")
	public String AntDirectoryController.show(@PathVariable("id") Long id, Model uiModel) {
		uiModel.addAttribute("antdirectory", AntDirectory.findAntDirectory(id));
		uiModel.addAttribute("itemId", id);

		System.out.println("In show method");


		return "antdirectorys/show";
	}

	@RequestMapping(produces = "text/html")
	public String AntDirectoryController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, @RequestParam(value = "sortFieldName", required = false) String sortFieldName, @RequestParam(value = "sortOrder", required = false) String sortOrder, Model uiModel) {
		if (page != null || size != null) {
			int sizeNo = size == null ? 10 : size.intValue();
			final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
			uiModel.addAttribute("antdirectorys", AntDirectory.findAntDirectoryEntries(firstResult, sizeNo, sortFieldName, sortOrder));
			float nrOfPages = (float) AntDirectory.countAntDirectorys() / sizeNo;
			uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
		} else {
			uiModel.addAttribute("antdirectorys", AntDirectory.findAllAntDirectorys(sortFieldName, sortOrder));
		}
		return "antdirectorys/list";
	}

	@RequestMapping( method = RequestMethod.POST,params="upload" , produces="text/html")
	public String AntDirectoryController.upload(@RequestParam("file") MultipartFile file,Model uiModel){
		String antFolderPath = null;
		String fileName = file.getOriginalFilename();
		 if (!file.isEmpty()) {
	            try {
	                byte[] bytes = file.getBytes();
	                File f = new File(UPLOAD_DIRECTORY);
	        		if(!f.exists()){
	        			FileUtils.forceMkdir(f);
	        		}else
	        			FileUtils.cleanDirectory(f);
	                System.out.println("file name :: "+fileName);
	                String fileLocation =UPLOAD_DIRECTORY+File.separator+fileName;
	                System.out.println("File Location :: "+fileLocation);
	                BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(new File(fileLocation)));
	                stream.write(bytes);
	                stream.close();
	                System.out.println("Project uploaded succesfully");
	                //Extract the zip file
	                FileUtility.extractUploadedZipProject(fileLocation, UNZIP_DIRECTORY);
	                System.out.println("Unzipped successfully at :: ");
	                AntDirectory antDirectory = new AntDirectory();
	    		 	antDirectory.setFolderPath(UNZIP_DIRECTORY+fileName.substring(0,fileName.lastIndexOf(".")));
	    			populateEditForm(uiModel, antDirectory);
	                
	            } catch (Exception e) {
	            	System.out.println("In Exception block");
	               e.getMessage();
	               return "antdirectorys/error";
	            }
	        } else {
	        	 System.out.println("empty folder");
	        }
		 	
		return "antdirectorys/create";
	}


	 @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String AntDirectoryController.update(@Valid AntDirectory antDirectory, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, antDirectory);
            return "antdirectorys/update";
        }
        System.out.println("In update method");
        uiModel.asMap().clear();
        antDirectory.merge();
        return "redirect:/antdirectorys/" + encodeUrlPathSegment(antDirectory.getId().toString(), httpServletRequest);
    }
	
	@RequestMapping(value = "/{id}", params = "form", produces = "text/html")
	public String AntDirectoryController.updateForm(@PathVariable("id") Long id, Model uiModel) {
		populateEditForm(uiModel, AntDirectory.findAntDirectory(id));
		return "antdirectorys/update";
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
	public String AntDirectoryController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
		AntDirectory antDirectory = AntDirectory.findAntDirectory(id);
		antDirectory.remove();
		uiModel.asMap().clear();
		uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
		uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
		return "redirect:/antdirectorys";
	}

	void AntDirectoryController.populateEditForm(Model uiModel, AntDirectory antDirectory) {
		uiModel.addAttribute("antDirectory", antDirectory);
	}

	String AntDirectoryController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
		String enc = httpServletRequest.getCharacterEncoding();
		if (enc == null) {
			enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
		}
		try {
			pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
		} catch (UnsupportedEncodingException uee) {}
		return pathSegment;
	}

	@RequestMapping(params="submit",value = "/{id}", produces = "text/html")
	public String AntDirectoryController.submit(@PathVariable("id") Long id, Model uiModel,HttpServletRequest request) {
		download_dir = "C:/download/";
		try{
			File f = new File(download_dir);
	 		if(!f.exists()){
	 			FileUtils.forceMkdir(f);
	 		}else
	 			FileUtils.cleanDirectory(f);
			}catch(IOException e){
				e.printStackTrace();
			}
		String projectName = null;
		uiModel.addAttribute("antdirectory", AntDirectory.findAntDirectory(id));
		uiModel.addAttribute("itemId", id);

		AntDirectory antDirectory = AntDirectory.findAntDirectory(id);
		System.out.println("ant directory values :: "+antDirectory.getConfigSRC());
		Map<String, String> antresources = new HashMap<String, String>();
		antresources.put(com.infy.constants.AntDirectory.LIB.toString(), antDirectory.getConfigLib());
		antresources.put(com.infy.constants.AntDirectory.PROJECT_FOLDER.toString(), antDirectory.getFolderPath());
		antresources.put(com.infy.constants.AntDirectory.SRC.toString(), antDirectory.getConfigSRC());
		antresources.put(com.infy.constants.AntDirectory.WEBCONTENT.toString(), antDirectory.getConfigWebSrc());
		antresources.put(com.infy.constants.AntDirectory.TESTSRC.toString(), antDirectory.getConfigTestpath());
		antresources.put("groupId", antDirectory.getGroupId());
		antresources.put("artifactId", antDirectory.getArtifactId());
		antresources.put("versionId", antDirectory.getVersionId());


		System.out.println("In submit method");
		System.out.println("TESt"+antresources.get(com.infy.constants.AntDirectory.TESTSRC.toString()));
		Convertor convertor = new Convertor();
		String mavenProjectFolder = convertor.convertAntToMaven(antresources);
		System.out.println("maven project Folder :: "+mavenProjectFolder);
		antDirectory.setMvnFolderPath(mavenProjectFolder);
		//request.setAttribute("mavenProjectFolder", mavenProjectFolder);
		
		projectName =(antDirectory.getFolderPath()).substring((antDirectory.getFolderPath()).lastIndexOf("/")+1);
		
		download_dir =download_dir+projectName+".zip";
		//antDirectory.setMvnFolderPath(download_dir);
		System.out.println("download dir :: "+download_dir);

		try {
		ZipUtility.zipDir(mavenProjectFolder,download_dir);
		} catch (Exception e) {
		// TODO Auto-generated catch block
		//e.printStackTrace();
		System.out.println("In download exception");
		return "antdirectorys/error";

		}


		if(mavenProjectFolder.equalsIgnoreCase(null)||mavenProjectFolder.equalsIgnoreCase(""))
		{
		return "antdirectorys/error";
		}


		return "antdirectorys/success";
	}


	@RequestMapping( method = RequestMethod.GET,params="download" )
	public void AntDirectoryController.download(HttpServletRequest request, HttpServletResponse response){
		try{
		
	//	PrintWriter out = response.getWriter();
		//OutputStream out = response.getOutputStream();
		
		
		  response.setContentType("application/zip"); 
		  response.setHeader("Content-Disposition","attachment; filename = MavenProject"); 
		  
		  System.out.println("download path :: "+download_dir);

		  FileInputStream fileInputStream = new FileInputStream(new File(download_dir));
		  ServletOutputStream out = response.getOutputStream();
		  
		  int i; 
		  while ((i=fileInputStream.read()) != -1) {
		    out.write(i); 
		  } 
		  fileInputStream.close(); 
		  out.flush();
		  out.close();
		   
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	


}