package mosing.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import mosing.service.LPTerdahuluService;
import mosing.model.LPTerdahuluModel;

@Controller
public class LPTerdahuluController {
	
	@Autowired
	LPTerdahuluService lptDAO;
	
	@RequestMapping("/data-pendaftar")
	public String add(Model model){
		List<LPTerdahuluModel> allLPT = lptDAO.selectAllLPT();
		model.addAttribute("allLPT", allLPT);
		return "form-data-terdahulu";
	}
}
