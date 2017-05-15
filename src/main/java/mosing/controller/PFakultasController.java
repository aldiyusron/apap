package mosing.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import mosing.model.FakultasModel;
import mosing.model.PendaftarModel;
import mosing.service.PFakultasService;
import mosing.service.PendaftarService;

@Controller
public class PFakultasController {
	
	@Autowired
	PFakultasService pfakultasDAO;
	
	@Autowired
	PendaftarService pendaftarDAO;
	
	@RequestMapping("/view/fakultas")
	public String lihatFakultas(Model model) {
		List<FakultasModel> fakultas = pfakultasDAO.selectAllFakultas();
		model.addAttribute("fakultas", fakultas);
		return "viewfakultas";
	}
	
	@RequestMapping("/view/pendaftar/{id_fakultas}")
	public String rekomendasi(Model model, @RequestParam(value = "id_fakultas", required = false) int id_fakultas) {
		List <PendaftarModel> pendaftar = pendaftarDAO.selectAllPendaftarNonRec(id_fakultas);
		model.addAttribute("pendaftar", pendaftar);
		return "recommending";
	}
}
