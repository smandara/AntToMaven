package com.infy.utility;

import javax.swing.JFileChooser;

public class BrowseUtility {

	public String BrowseFolder() {

		JFileChooser chooser = new JFileChooser();
		try {

			chooser.setDialogTitle("choosertitle");
			chooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
			chooser.setAcceptAllFileFilterUsed(false);

			if (chooser.showOpenDialog(null) == JFileChooser.APPROVE_OPTION) {
				System.out.println("getCurrentDirectory(): " + chooser.getCurrentDirectory());
				System.out.println("getSelectedFile() : " + chooser.getSelectedFile());
			} else {
				System.out.println("No Selection ");
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			return "Please select the folder";
		}

		return chooser.getSelectedFile().toString();
	}

}
