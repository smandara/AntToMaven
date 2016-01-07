package com.infy.controllers;
import com.infy.entities.AntDirectory;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/antdirectorys")
@Controller
@RooWebScaffold(path = "antdirectorys", formBackingObject = AntDirectory.class)
public class AntDirectoryController {
	
	
	
}
