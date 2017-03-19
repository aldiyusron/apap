package mosing.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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

	@RequestMapping("/done")
	public String done() {
		return "done";
	}

	@RequestMapping(value = "/forgotPassword")
	public String forgotPassword() {
		return "forgotPwd";
	}

	@RequestMapping(value = "/resetPassword")
	public String resetRequest(Model model, @RequestParam(value = "username") String username) {
		UserAdmisiModel user = userDAO.selectUser(username);
		if(user == null)
			return "login";
		model.addAttribute("user", user);
		return "newPassword";
	}

	@RequestMapping(value = "/resetPassword/submit")
	public String resetRequest(@RequestParam(value = "username") String username,
			@RequestParam(value = "password") String password, @RequestParam(value = "email") String email) {

		UserAdmisiModel user = userDAO.selectUser(username);
		if (user == null)
			return "login";
		user.setPassword(password);
		userDAO.updateUser(user);
		return "success-registration";
	}
}