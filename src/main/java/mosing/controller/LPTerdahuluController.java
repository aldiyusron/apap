package mosing.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import mosing.service.JalurMasukService;
import mosing.service.LPTerdahuluService;
import mosing.service.PendaftarService;
import mosing.service.UserAdmisiService;
import mosing.model.JalurMasukModel;
import mosing.model.LPTerdahuluModel;
import mosing.model.ProdiTersediaModel;
import mosing.model.UserAdmisiModel;

@Controller
public class LPTerdahuluController {

	@Autowired
	LPTerdahuluService lptDAO;

	@Autowired
	PendaftarService pendaftarDAO;
	
	@Autowired
	JalurMasukService jalurMasukDAO;
	
	@Autowired
	UserAdmisiService userDAO;

	@RequestMapping("/data-pendaftar")
	public String addData(Model model) {
		List<LPTerdahuluModel> allLPT = lptDAO.selectAllLPT();
		List<JalurMasukModel> jalurUndangan = jalurMasukDAO.selectAllJalurUndangan();
		JalurMasukModel jalurPPKB = jalurMasukDAO.selectJalurMasuk(4);
		List<ProdiTersediaModel> prodi = jalurPPKB.getListProdi();
		model.addAttribute("prodi", prodi);
		model.addAttribute("jalurUndangan", jalurUndangan);
		model.addAttribute("allLPT", allLPT);
		return "form-data-terdahulu";
	}
	
	@RequestMapping("/LPT/list/user")
	public String listUser(Model model)
	{
		List<UserAdmisiModel> user = userDAO.selectAllLPTUser();
		model.addAttribute("user", user);
		return "LPTUserList";
	}
}
