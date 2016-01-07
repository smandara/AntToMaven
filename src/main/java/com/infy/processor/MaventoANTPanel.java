package com.infy.processor;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import javax.swing.BoxLayout;
import javax.swing.GroupLayout;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTabbedPane;
import javax.swing.JTextField;
import javax.swing.SwingUtilities;
import javax.swing.UIManager;

import com.infy.constants.AntDirectory;
 
public class MaventoANTPanel extends JPanel {
	
	private Map<String, String> antResources = new HashMap<String, String>();
	
    public MaventoANTPanel() {
        super(new GridLayout(1, 1));
         
        JTabbedPane tabbedPane = new JTabbedPane();
       ImageIcon icon = null;
         
        JComponent projectFolderPanel = makeProjectFolderPanel("Specify ANT project folder path:",tabbedPane);
       
        projectFolderPanel.setPreferredSize(new Dimension(700, 400));
       // JTextComponent jTextField = new JTextField();
        tabbedPane.addTab("Project Folder", icon, projectFolderPanel,
                "Update Project Folder");
        
        tabbedPane.setMnemonicAt(0, KeyEvent.VK_1);
         
        JComponent panel2 = makeSourceFolderPanel("Source folder with reference to project root: ",tabbedPane);
        tabbedPane.addTab("Configure Source", icon, panel2,
                "Update Source Folder Name");
        tabbedPane.setMnemonicAt(1, KeyEvent.VK_2);
        
        JComponent panel3 = makeExtSourcePanel("Source folder with reference to project root: ",tabbedPane);
        tabbedPane.addTab("External Sources", icon, panel3,
                "Update Source Folder Name");
        tabbedPane.setMnemonicAt(2, KeyEvent.VK_3);
         
        JComponent panel4 = makeTestFolderPanel("Test case folder with reference to project root: ", tabbedPane);
        tabbedPane.addTab("Configure Test", icon, panel4,
                "Update Test Folder Name");
        tabbedPane.setMnemonicAt(3, KeyEvent.VK_4);
        
        JComponent panel5 = makeWebContentFolderPanel(
                "WebContent folder with reference to project root: ", tabbedPane);
        tabbedPane.addTab("Configure Web Resources", icon, panel5,
                "Update WebContent Folder Name");
        tabbedPane.setMnemonicAt(4, KeyEvent.VK_5);
        
        JComponent panel6 = makeLibraryPanel(
                "Lib folder with reference to project root: ", tabbedPane);
        tabbedPane.addTab("Configure Libraries", icon, panel6,
                "Update Lib Folder Name");
        tabbedPane.setMnemonicAt(5, KeyEvent.VK_6);
        
        
         
        //Add the tabbed pane to this panel.
        add(tabbedPane);
         
        //The following line enables to use scrolling tabs.
        tabbedPane.setTabLayoutPolicy(JTabbedPane.SCROLL_TAB_LAYOUT);
    }
     
    protected JComponent makeTextPanel(String text) {
        JPanel panel = new JPanel(false);
        JLabel filler = new JLabel(text);
        filler.setHorizontalAlignment(JLabel.LEFT);
        filler.setVerticalAlignment(JLabel.TOP);
        JTextField projectFolderPath = new JTextField(20);
        /*projectFolderPath.setBounds(51, 200, 164, 94);
        projectFolderPath.setSize(200, 100);*/
        //projectFolderPath.setPreferredSize(new Dimension(100, 30));
        //panel.setLayout(new GridLayout(1, 1));
        panel.add(filler);
        panel.add(projectFolderPath);
        return panel;
    }
    
    protected JComponent makeExtSourcePanel(String text, final JTabbedPane tabbedPane) {
        JPanel panel = new JPanel(false);
        
        JLabel artFiller = new JLabel("Artifact Id");
        JTextField artifactId = new JTextField(20);
        panel.add(artFiller);
        panel.add(artifactId);
        
        JLabel grpFiller = new JLabel("GroupId");
        JTextField groupId = new JTextField(20);
        panel.add(grpFiller);
        panel.add(groupId);
        
        JLabel verFiller = new JLabel("Version Id");
        JTextField versionId = new JTextField(20);
        panel.add(verFiller);
        panel.add(versionId);
        
        navigateTabNextOptional(panel,tabbedPane,3,"Next","artifactId",artifactId,"groupId",groupId,"versionId",versionId);    
        navigateTabBack(panel,tabbedPane,1,"Back");  
        return panel;
    }
    
    protected JComponent makeTestFolderPanel(String text, final JTabbedPane tabbedPane) {
        JPanel panel = new JPanel(false);
        JLabel filler = new JLabel(text);
        filler.setHorizontalAlignment(JLabel.LEFT);
        filler.setVerticalAlignment(JLabel.TOP);
        JTextField testFolderPath = new JTextField(20);
        panel.add(filler);
        panel.add(testFolderPath);
        navigateTabNext(panel,tabbedPane,4,"Next",AntDirectory.TESTSRC.toString(),testFolderPath);    
        navigateTabBack(panel,tabbedPane,2,"Back");  
        return panel;
    }
    
    protected JComponent makeWebContentFolderPanel(String text, final JTabbedPane tabbedPane) {
        JPanel panel = new JPanel(false);
        JLabel filler = new JLabel(text);
        filler.setHorizontalAlignment(JLabel.LEFT);
        filler.setVerticalAlignment(JLabel.TOP);
        JTextField webContentFolderPath = new JTextField(20);
        panel.add(filler);
        panel.add(webContentFolderPath);
        navigateTabNext(panel,tabbedPane,5,"Next",AntDirectory.WEBCONTENT.toString(),webContentFolderPath);   
        navigateTabBack(panel,tabbedPane,3,"Back");
        return panel;
    }
    
    protected JComponent makeLibraryPanel(String text, final JTabbedPane tabbedPane) {
        final JPanel panel = new JPanel(false);
        JLabel filler = new JLabel(text);
        filler.setHorizontalAlignment(JLabel.LEFT);
        filler.setVerticalAlignment(JLabel.TOP);
        final JTextField libFolderPath = new JTextField(20);
       
        panel.add(filler);
        panel.add(libFolderPath);
       
        JButton subButton = new JButton("Submit");
        subButton.setBounds(75, 82, 90, 31);
       // nextButton.
        panel.add(subButton);
        subButton.addActionListener(new ActionListener() {
        	public void actionPerformed(ActionEvent arg0) {
        		antResources.put(AntDirectory.LIB.toString(), libFolderPath.getText());
        		System.out.println("antResources: " + antResources);
        		String antResourcesStr = "";
        		Map<String, String> antResourcesSorted = new TreeMap<String, String>(antResources);
        		for(Map.Entry<String, String> entry : antResourcesSorted.entrySet()){
        			antResourcesStr = antResourcesStr + entry.getKey() + ": " + entry.getValue() + "\n";
        			}
        		if((antResources.get(AntDirectory.LIB.toString()).equalsIgnoreCase("")||antResources.get(AntDirectory.LIB.toString())==null)
        				||!antResourcesStr.contains(AntDirectory.PROJECT_FOLDER.toString())||!antResourcesStr.contains(AntDirectory.SRC.toString())
        				||!antResourcesStr.contains(AntDirectory.TESTSRC.toString())||!antResourcesStr.contains(AntDirectory.WEBCONTENT.toString())){
        			 if(!antResourcesStr.contains(AntDirectory.PROJECT_FOLDER.toString())){
         				JOptionPane.showMessageDialog(panel, "Project Folder"+" Incomplete data entry");
         			
         			}else if(!antResourcesStr.contains(AntDirectory.SRC.toString())){
    				JOptionPane.showMessageDialog(panel, "Configure Source Folder"+" Incomplete data entry");
        			}
        			else if(!antResourcesStr.contains(AntDirectory.TESTSRC.toString())){
        				JOptionPane.showMessageDialog(panel, "Test folder"+" Incomplete data entry");
        			
        			}
        			else if(!antResourcesStr.contains(AntDirectory.WEBCONTENT.toString())){
        				JOptionPane.showMessageDialog(panel, "WebContent folder"+" Incomplete data entry");        			
        			}else if (antResources.get(AntDirectory.LIB.toString()).equalsIgnoreCase("")||antResources.get(AntDirectory.LIB.toString())==null){
        				JOptionPane.showMessageDialog(panel, "lib folder"+" Incomplete data entry");  
        			}
        			
        			
    			} else{
    				JOptionPane.showMessageDialog(panel, antResourcesStr);
    				Convertor convertor = new Convertor();
            		String mavenProjectFolder = convertor.convertAntToMaven(antResources);
            		JOptionPane.showMessageDialog(panel, "Maven Project created succesfully at " + mavenProjectFolder);
    			}
    		
        		
        	}
        	
        });
       // navigateTab(panel,tabbedPane,3,"Next");       
        
        navigateTabBack(panel,tabbedPane,4,"Back");
        
        return panel;
    }
    
    protected JComponent makeSourceFolderPanel(String text, final JTabbedPane tabbedPane) {
        JPanel panel = new JPanel(false);
        JLabel desc = new JLabel();
        desc.setText("Enter Source folder with reference to project root (Ex: src)");
        panel.add(desc);
        JTextField sourceFolderPath = new JTextField(20);
        panel.add(sourceFolderPath);
        navigateTabNext(panel,tabbedPane,2,"Next",AntDirectory.SRC.toString(),sourceFolderPath);   
        navigateTabBack(panel,tabbedPane,0,"Back");
        return panel;
    }
    
    private void navigateTabBack(JPanel panel,final JTabbedPane tabbedPane,final int index, String label){
    	 JButton backButton = new JButton(label);
         backButton.setBounds(75, 82, 90, 31);
        // nextButton.
         panel.add(backButton);
         backButton.addActionListener(new ActionListener() {
         	public void actionPerformed(ActionEvent arg0) {
         		System.out.println("antResources: " + antResources);
         		tabbedPane.setSelectedIndex(index);
         	}
         	
         });
    }
    
    private void navigateTabNext(final JPanel panel,final JTabbedPane tabbedPane,final int index, String label,
    		final String panelKey, final JTextField folderName){
    	 JButton backButton = new JButton(label);
         backButton.setBounds(75, 82, 90, 31);
        // nextButton.
         panel.add(backButton);
         backButton.addActionListener(new ActionListener() {
         	public void actionPerformed(ActionEvent arg0) {
         		if(folderName.getText().equalsIgnoreCase("")){
         			JOptionPane.showMessageDialog(panel, "No Data Entry!!");
         		}
         		else{
         		antResources.put(panelKey, folderName.getText());
         		System.out.println("folderName.getSelectedText(): " + folderName.getText());
         		System.out.println("antResources: " + antResources);
         		tabbedPane.setSelectedIndex(index);
         		}
         	}
         	
         });
    }
    
    private void navigateTabNextOptional(final JPanel panel,final JTabbedPane tabbedPane,final int index, String label,
    		final String artifactId, final JTextField artifactValue,final String groupId, 
    		final JTextField groupValue,final String versionId, final JTextField versionValue){
    	 JButton backButton = new JButton(label);
         backButton.setBounds(75, 82, 90, 31);
        // nextButton.
         panel.add(backButton);
         backButton.addActionListener(new ActionListener() {
         	public void actionPerformed(ActionEvent arg0) {
         		
         		antResources.put(artifactId, artifactValue.getText());
         		antResources.put(groupId, groupValue.getText());
         		antResources.put(versionId, versionValue.getText());
         		System.out.println("antResources: " + antResources);
         		tabbedPane.setSelectedIndex(index);
         	}
         	
         });
    }
    
    private void navigateTab(final JPanel panel,final JTabbedPane tabbedPane,final int index,final String label
    		){
    	 JButton backButton = new JButton(label);
         backButton.setBounds(75, 82, 90, 31);
        // nextButton.
         panel.add(backButton);
         backButton.addActionListener(new ActionListener() {
         	public void actionPerformed(ActionEvent arg0) {
         		tabbedPane.setSelectedIndex(index);
         	}
         	
         });
    }
    
    protected JComponent makeProjectFolderPanel(String text, final JTabbedPane tabbedPane) {
        JPanel panel = new JPanel(false);
        JLabel filler = new JLabel(text);
        
        //filler.setHorizontalAlignment(JLabel.LEFT);
       // filler.setVerticalAlignment(JLabel.TOP);
        final JTextField projectFolderPath = new JTextField(20);
        projectFolderPath.setEditable(false);
        panel.add(filler);
        panel.add(projectFolderPath);
        
        final JButton browseButton = new JButton("Browse");
        //btnNewButton.setBounds(258, 26, 105, 31);
        
        browseButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent arg0) {
                try{
                JFileChooser filedilg=new JFileChooser();
                filedilg.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
                filedilg.showOpenDialog(filedilg);
                String fileName=filedilg.getSelectedFile().getAbsolutePath();
                if(fileName.equalsIgnoreCase("")){
                }
                projectFolderPath.setText(fileName);
                System.out.println("fileName: " + fileName);
                antResources.put(AntDirectory.PROJECT_FOLDER.toString(), fileName);
                
                }
                catch(Exception e){
                    e.printStackTrace();
                }
            }
          });
        //browseButton.setFont(new Font("Times New Roman", Font.PLAIN, 14));
        
        panel.add(browseButton);
        
        navigateTab(panel,tabbedPane,1,"Next");  
        return panel;
    }
     
    /** Returns an ImageIcon, or null if the path was invalid. */
    protected static ImageIcon createImageIcon(String path) {
        java.net.URL imgURL = MaventoANTPanel.class.getResource(path);
        if (imgURL != null) {
            return new ImageIcon(imgURL);
        } else {
            System.err.println("Couldn't find file: " + path);
            return null;
        }
    }
     
    /**
     * Create the GUI and show it.  For thread safety,
     * this method should be invoked from
     * the event dispatch thread.
     */
    private static void createAndShowGUI() {
        //Create and set up the window.
        JFrame frame = new JFrame("TabbedPaneDemo");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
         
        //Add content to the window.
        frame.add(new MaventoANTPanel(), BorderLayout.CENTER);
         
        //Display the window.
        frame.pack();
        frame.setVisible(true);
    }
     
    public static void main(String[] args) {
        //Schedule a job for the event dispatch thread:
        //creating and showing this application's GUI.
        SwingUtilities.invokeLater(new Runnable() {
            public void run() {
                //Turn off metal's use of bold fonts
        UIManager.put("swing.boldMetal", Boolean.FALSE);
        createAndShowGUI();
            }
        });
    }
}