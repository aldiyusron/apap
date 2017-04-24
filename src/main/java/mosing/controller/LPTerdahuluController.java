package mosing.controller;

import java.text.ParseException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import mosing.service.LPTerdahuluService;
import mosing.service.PendaftarService;
import mosing.model.LPTerdahuluModel;
import mosing.model.PendaftarModel;

@Controller
public class LPTerdahuluController {

	@Autowired
	LPTerdahuluService lptDAO;

	@Autowired
	PendaftarService pendaftarDAO;

	@RequestMapping("/data-pendaftar")
	public String addData(Model model) {
		List<LPTerdahuluModel> allLPT = lptDAO.selectAllLPT();
		model.addAttribute("allLPT", allLPT);
		return "form-data-terdahulu";
	}

	@RequestMapping("/data-pendaftar/submit")
	public String addSubmit(@RequestParam(value = "nama_id", required = false) String nama_id,
			@RequestParam(value = "nama_ijazah", required = false) String nama_ijazah,
			@RequestParam(value = "no_id", required = false) String no_id,
			@RequestParam(value = "nama_lembaga", required = false) String nama_lembaga,
			@RequestParam(value = "jurusan", required = false) String jurusan) throws ParseException {

		// if (jurusan.equalsIgnoreCase("IPA"))
		// jurusan = "1";
		// else
		// jurusan = "0";

		PendaftarModel pendaftar = new PendaftarModel(0, no_id, nama_id, nama_ijazah, null, null, null, null, null,
				null, null, null, null, null, null, (byte) 0, nama_lembaga, jurusan, 0);
		pendaftarDAO.addPendaftar(pendaftar);
		if (pendaftar.getJurusan().equals("IPA"))
			return "form-nilai-ipa";
		else
			return "form-nilai-ips";
	}

}
