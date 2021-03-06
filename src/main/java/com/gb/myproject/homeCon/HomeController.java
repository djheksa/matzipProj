package com.gb.myproject.homeCon;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gb.myproject.store.service.StoreService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
    StoreService service;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@RequestMapping(value = {"/","/index"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model,HttpServletRequest request , String login) {
		if(login!=null) {
			model.addAttribute("login", login);
		}
		 model.addAttribute("stations",service.getStationName());
		return "index";
	}
	
}
