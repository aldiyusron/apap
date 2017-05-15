package mosing.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PemimpinUnivController {
	
	@RequestMapping("/dashboard")
	public String dashboard(){
		return "dashboard";
	}

}
