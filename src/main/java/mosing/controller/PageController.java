package mosing.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import mosing.model.JalurMasukModel;
import mosing.model.UserAdmisiModel;
import mosing.service.JalurMasukService;
import mosing.service.UserAdmisiService;
//testing
@Controller
public class PageController {
	@Autowired
	UserAdmisiService userDAO;
	
	@Autowired
	JalurMasukService jalurMasukDAO;
	
	@RequestMapping("/")
	public String login(Model model){
		UserAdmisiModel user = userDAO.selectUser();
		JalurMasukModel jalurMasuk = jalurMasukDAO.selectJalurMasuk(4);
		List<JalurMasukModel> allJalurMasuk = jalurMasukDAO.selectAllJalurMasuk();
		model.addAttribute("allJalurMasuk", allJalurMasuk);
		model.addAttribute("user", user);
		model.addAttribute("jalurMasuk", jalurMasuk);		
		if(user!=null){
		return "home";
		} else {
			return "index";
		}
	}

	@RequestMapping("/login")
	public String login() {
		return "login";
	}
}