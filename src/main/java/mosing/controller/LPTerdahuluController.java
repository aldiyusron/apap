package mosing.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import mosing.service.LPTerdahuluService;

@Controller
public class LPTerdahuluController {
	
	@Autowired
	LPTerdahuluService lptDAO;
	
	@RequestMapping("/nilai-pendaftar")
	public String add()
	{
		return "form-data-terdahulu";
	}
}
