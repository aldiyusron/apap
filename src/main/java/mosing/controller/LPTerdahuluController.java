package mosing.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import mosing.service.LPTerdahuluService;
import mosing.model.LPTerdahuluModel;
import mosing.model.NilaiModel;

@Controller
public class LPTerdahuluController {
	
	@Autowired
	LPTerdahuluService lptDAO;
	
	@RequestMapping("/data-pendaftar")
	public String addData(Model model){
		List<LPTerdahuluModel> allLPT = lptDAO.selectAllLPT();
		model.addAttribute("allLPT", allLPT);
		return "form-data-terdahulu";
	}
}
