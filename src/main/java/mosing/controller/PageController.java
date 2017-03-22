package mosing.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import mosing.model.UserAdmisiModel;
import mosing.service.UserAdmisiService;

@Controller
public class PageController {
	@Autowired
	UserAdmisiService userDAO;
	
	@RequestMapping("/")
	public String login(Model model){
		UserAdmisiModel user = userDAO.selectUser();
		model.addAttribute("user", user);
		if(user!=null){
		return "home";
		} else {
			return "login";
		}
	}

	@RequestMapping("/index")
	public String index() {
		return "index";
	}

	@RequestMapping("/login")
	public String login() {
		return "login";
	}
}