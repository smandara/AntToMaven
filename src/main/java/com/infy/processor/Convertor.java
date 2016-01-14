/**
 * 
 */
package com.infy.processor;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;
import java.util.StringTokenizer;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.filefilter.DirectoryFileFilter;
import org.apache.commons.io.filefilter.FileFileFilter;
import org.apache.commons.io.filefilter.FileFilterUtils;
import org.apache.commons.io.filefilter.IOFileFilter;

import com.infy.constants.AntDirectory;
import com.infy.constants.MavenDirectory;
import com.infy.utility.PomGenerator;

/**
 * @author test
 *
 */
public class Convertor {

	/*
	 * public static void main(String[] args) throws Exception {
	 * 
	 * ResourceUtil resourceUtil=new ResourceUtil();
	 * 
	 * if(resourceUtil.createProjectResource()){ Convertor convertor = new
	 * Convertor();
	 * 
	 * convertor.copyFilesToMaven(); }
	 * 
	 * }
	 */

	public String convertAntToMaven(Map<String, String> antResources) {

		ResourceUtil resourceUtil = new ResourceUtil();
		String mavenProjectFolder = "";
		try {
			if (resourceUtil.createProjectResource()) {
				Convertor convertor = new Convertor();

				mavenProjectFolder = convertor.copyFilesToMaven(antResources);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return mavenProjectFolder;
	}

	public String copyFilesToMaven(Map<String, String> antResources)
			throws Exception {

		String antProjectFolder = antResources.get(AntDirectory.PROJECT_FOLDER
				.toString());
		ResourceBundle mavenResources = ResourceBundle
				.getBundle("MavenResources");
		String mavenProjectFolder = mavenResources.getString("APP_NAME_SPACE");
		// Copying the src files
		String antSrcDir = antResources.get(AntDirectory.SRC.toString());

		StringTokenizer antSrcTokens = new StringTokenizer(antSrcDir, ",");
		List<String> antDirList = new ArrayList<>();

		while (antSrcTokens.hasMoreTokens()) {
			antDirList.add(antProjectFolder + "//" + antSrcTokens.nextToken());
		}

		System.out.println("antDirList: " + antDirList);
		String mavenSrcDir = mavenProjectFolder
				+ mavenResources.getString(MavenDirectory.SRC_MAIN_JAVA
						.toString());
		copyFiles(antDirList, mavenSrcDir, "java");

		// Copying the properties referred in Source
		String mavenSrcResDir = mavenProjectFolder
				+ mavenResources.getString(MavenDirectory.SRC_MAIN_RESOURCES
						.toString());
		copyFiles(antDirList, mavenSrcResDir, "properties");

		// Copying the Test Cases
		
		
		String antTestDir = antProjectFolder + "//"
				+ antResources.get(AntDirectory.TESTSRC.toString());
		
		if(antTestDir!=null){
		String mavenTestDir = mavenProjectFolder                                 //Added to remove mandatory field of test folder
				+ mavenResources.getString(MavenDirectory.SRC_TEST_JAVA
						.toString());
		copyFiles(antTestDir, mavenTestDir, "java");}
		

		// Copying the properties referred in Test Cases
		String mavenTestResDir = mavenProjectFolder
				+ mavenResources.getString(MavenDirectory.SRC_TEST_RESOURCES
						.toString());
		copyFiles(antTestDir, mavenTestResDir, "properties");

		String antWebDir = antProjectFolder + "//"
				+ antResources.get(AntDirectory.WEBCONTENT.toString());
		String mavenWebDir = mavenProjectFolder
				+ mavenResources.getString(MavenDirectory.SRC_MAIN_WEBAPP
						.toString());
		String arr[] = new String[]{"jar","class"};
		System.out.println("antWebDIr :: "+antWebDir);
		copyFilesExclusion(antWebDir, mavenWebDir,arr);

		String antLibDir = antProjectFolder + "//"
				+ antResources.get(AntDirectory.LIB.toString());

		String groupId = antResources.get("groupId");
		String artifactId = antResources.get("artifactId");
		String version = antResources.get("versionId");

		if (groupId != null && artifactId != null && version != null) {

			new PomGenerator().pomFileGenerator(antLibDir, mavenProjectFolder,
					groupId, artifactId, version);

		} else {

			new PomGenerator().pomFileGenerator(antLibDir, mavenProjectFolder);

		}

		// Copying the webcontent files
		// copyFiles(AntDirectory.WEBAPP,MavenDirectory.SRC_MAIN_WEBAPP);

		// Copying the Test Files
		// copyFiles(AntDirectory.TESTSRC,MavenDirectory.SRC_TEST_JAVA);

		return mavenProjectFolder;
	}

	public static void main(String[] args) throws Exception {
		String antDir = "C:/WorkSpace/CCKTestClient/CCKTestClient";
		String mavenDir = "C:/SampleMavenApp/src/main/webapp";
		String arr[] = new String[]{"jar","class"};
		new Convertor().copyFilesExclusion(antDir, mavenDir,arr);

	}

	public void copyFilesExclusion(String antDir, String mavenDir,String...exts) throws Exception{

		System.out.println("antWebDIr :: "+antDir);

		File antFile = new File(antDir);


		Collection<File> listFiles = FileUtils.listFiles(antFile, null, true);
		HashSet<String> excludeExts = new HashSet<String>();
		for (File file : listFiles) {
			String fileExt = file.toString().substring(file.toString().lastIndexOf(".")+1);
			excludeExts.add(fileExt);



		}
		for(String extns:exts)
			excludeExts.remove(extns);

		String []returnArray = new String[excludeExts.size()];

		Iterator<String> iterator = excludeExts.iterator();
		int i=0;
		while(iterator.hasNext()){
			returnArray[i]=iterator.next();
			i++;
		}
		copyFiles(antDir, mavenDir,returnArray);

	}

	public void copyFiles(String antDir, String mavenDir, String... extension)
			throws Exception {

		File antFile = new File(antDir);
		File mavenFile = new File(mavenDir);

		if (extension != null && extension.length!=0) {



			List<File> files = (List<File>) FileUtils.listFiles(antFile,
					extension, true);

			for (File file : files) {

				String filePath = file.getAbsolutePath();
				File tempFile = new File(antDir);
				int index = tempFile.getAbsolutePath().length();

				String subString = filePath.substring(index, filePath.length());

				File antTempFile = new File(antDir + subString);
				File mavenTempFile = new File(mavenDir + subString);

				FileUtils.copyFile(antTempFile, mavenTempFile);

			}

		} else {
			FileUtils.copyDirectory(antFile, mavenFile);
		}

	}
	
	public void copyFiles(List<String> antDirs, String mavenDir, String... extension)
			throws Exception {

		for(String antDir: antDirs){
			
			System.out.println("copying antDir :"+ antDir);
		File antFile = new File(antDir);
		File mavenFile = new File(mavenDir);

		if (extension != null && extension.length!=0) {



			List<File> files = (List<File>) FileUtils.listFiles(antFile,
					extension, true);

			for (File file : files) {

				String filePath = file.getAbsolutePath();
				
				
				File tempFile = new File(antDir);
				int index = tempFile.getAbsolutePath().length();

				String subString = filePath.substring(index, filePath.length());

				File antTempFile = new File(antDir + subString);
				File mavenTempFile = new File(mavenDir + subString);

				FileUtils.copyFile(antTempFile, mavenTempFile);

			}

		} else {
			FileUtils.copyDirectory(antFile, mavenFile);
		}
		System.out.println("copied antDir :"+ antDir);

		}


	}

	public void copyFiles(AntDirectory ant, MavenDirectory maven)
			throws Exception {

		ResourceBundle antBundle = ResourceBundle.getBundle("AntResources");
		ResourceBundle mavenBundle = ResourceBundle.getBundle("MavenResources");

		String antPath = null;
		try {
			antPath = antBundle.getString(ant.toString());
			System.out.println("Ant ");
		} catch (Exception e) {
			System.out.println("Ant path not defined for " + ant.toString());
		}

		String mavenPath = null;

		try {
			mavenPath = mavenBundle.getString("APP_NAME_SPACE")
					+ mavenBundle.getString(maven.toString());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		if (antPath != null && mavenPath != null) {

			File antFile = new File(antPath);
			File mavenFile = new File(mavenPath);

			// antFile.get

			// FileUtils.copyDirectory(antFile, mavenFile);

			IOFileFilter txtSuffixFilter = FileFilterUtils
					.suffixFileFilter(".java");
			IOFileFilter txtFiles = FileFilterUtils.andFileFilter(
					FileFileFilter.FILE, txtSuffixFilter);
			// Create a filter for either directories or ".txt" files
			FileFilter filter = FileFilterUtils.orFileFilter(
					DirectoryFileFilter.DIRECTORY, txtFiles);

			// Copy using the filter
			FileUtils.copyDirectory(antFile, mavenFile, filter);

			System.out.println("Copied the files from " + antPath + " to "
					+ mavenPath);

		} else {
			System.out.println("One of the maven or ant path is missing");
		}

	}



}
