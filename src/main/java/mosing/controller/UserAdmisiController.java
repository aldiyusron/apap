package mosing.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import mosing.model.UserAdmisiModel;
import mosing.service.UserAdmisiService;

@Controller
public class UserAdmisiController {

	@Autowired
	UserAdmisiService userDAO;
	
	@RequestMapping("/register")
	public String add()
	{
		return "form-registrasi1";
	}
	
	@RequestMapping("/register/submit")
	public String addSubmit(@RequestParam(value = "username", required = false) String username,
			@RequestParam(value = "password", required = false) String password,
			@RequestParam(value = "email", required = false) String email,
			@RequestParam(value = "role", required = false) String role)
	{
		if(role.equalsIgnoreCase("Pendaftar Seleksi"))
		{
			role = "ROLE_PEND";
		}
		else
		{
			role = "ROLE_PENG_U";
		}
		UserAdmisiModel userAdmisi = new UserAdmisiModel(username, password, email, role);
		userDAO.addUser(userAdmisi);
		return "success-registration";
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
		return "successResetPwd";
	}
}
