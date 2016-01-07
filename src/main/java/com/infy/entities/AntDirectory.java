package com.infy.entities;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.activerecord.RooJpaActiveRecord;
import org.springframework.roo.addon.tostring.RooToString;
import javax.validation.constraints.NotNull;

@RooJavaBean
@RooToString
@RooJpaActiveRecord
public class AntDirectory {

    /**
     */
   // @NotNull
    private String folderPath;

    /**
     */
   // @NotNull
    private String configSRC;

    /**
     */
  //  @NotNull
    private String configLib;

    /**
  //   */
 // @NotNull
    private String configTestpath;

    /**
     */
    private String artifactId;

    /**
     */
    private String groupId;

    /**
     */
    private String versionId;

    /**
     */
   // @NotNull
    private String configWebSrc;
    
    private String mvnFolderPath;
}
