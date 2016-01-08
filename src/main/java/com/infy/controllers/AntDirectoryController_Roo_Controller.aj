// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.infy.controllers;

import com.infy.controllers.AntDirectoryController;
import com.infy.entities.AntDirectory;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect AntDirectoryController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String AntDirectoryController.create(@Valid AntDirectory antDirectory, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, antDirectory);
            return "antdirectorys/create";
        }
        uiModel.asMap().clear();
        antDirectory.persist();
        return "redirect:/antdirectorys/" + encodeUrlPathSegment(antDirectory.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String AntDirectoryController.createForm(Model uiModel) {
        populateEditForm(uiModel, new AntDirectory());
        return "antdirectorys/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String AntDirectoryController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("antdirectory", AntDirectory.findAntDirectory(id));
        uiModel.addAttribute("itemId", id);
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
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String AntDirectoryController.update(@Valid AntDirectory antDirectory, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, antDirectory);
            return "antdirectorys/update";
        }
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
    
}
