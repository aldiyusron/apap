package mosing.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import mosing.service.JalurMasukService;
import mosing.service.LPTerdahuluService;
import mosing.service.PendaftarService;
import mosing.model.JalurMasukModel;
import mosing.model.LPTerdahuluModel;

@Controller
public class LPTerdahuluController {

	@Autowired
	LPTerdahuluService lptDAO;

	@Autowired
	PendaftarService pendaftarDAO;
	
	@Autowired
	JalurMasukService jalurMasukDAO;

	@RequestMapping("/data-pendaftar")
	public String addData(Model model) {
		List<LPTerdahuluModel> allLPT = lptDAO.selectAllLPT();
		List<JalurMasukModel> jalurUndangan = jalurMasukDAO.selectAllJalurUndangan();
		model.addAttribute("jalurUndangan", jalurUndangan);
		model.addAttribute("allLPT", allLPT);
		return "form-data-terdahulu";
	}
}
