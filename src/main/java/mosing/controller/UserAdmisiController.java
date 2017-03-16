package mosing.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import mosing.service.UserAdmisiService;

@Controller
public class UserAdmisiController {
	@Autowired
	UserAdmisiService userAdmisiDAO;

	@RequestMapping("/login")
	public String login() {
		return "login";
	}
}
