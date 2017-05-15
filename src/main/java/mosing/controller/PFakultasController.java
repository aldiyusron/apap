package mosing.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import mosing.model.FakultasModel;
import mosing.model.PendaftarModel;
import mosing.model.ProdiTersediaModel;
import mosing.service.PFakultasService;
import mosing.service.PendaftarService;
import mosing.service.ProdiService;

@Controller
public class PFakultasController {
	
	@Autowired
	PFakultasService pfakultasDAO;
	
	@Autowired
	PendaftarService pendaftarDAO;
	
	@Autowired
	ProdiService prodiDAO;
	
	@RequestMapping("/view/fakultas")
	public String lihatFakultas(Model model) {
		List<FakultasModel> fakultas = pfakultasDAO.selectAllFakultas();
		for(int i = 0; i < fakultas.size(); i++)
		{
			int id_fakultas = fakultas.get(i).getId_fakultas();
			List<ProdiTersediaModel> prodi = prodiDAO.selectAllProdiFak(id_fakultas);
			fakultas.get(i).setProdi(prodi);
		}
		model.addAttribute("fakultas", fakultas);
		return "view-fakultasRecommending";
	}
	
	@RequestMapping("/view/pendaftar/{id_fakultas}")
	public String rekomendasikan(Model model, @RequestParam(value = "id_fakultas", required = false) int id_fakultas) {
		List <PendaftarModel> pendaftar = pendaftarDAO.selectAllPendaftarNonRec(id_fakultas);
		model.addAttribute("pendaftar", pendaftar);
		return "recommending";
	}
	
	@RequestMapping("/view/pendaftar/rec/{id_fakultas}")
	public String rekomendasi(Model model, @RequestParam(value = "id_fakultas", required = false) int id_fakultas) {
		List <PendaftarModel> pendaftar = pendaftarDAO.selectAllPendaftarRec(id_fakultas);
		model.addAttribute("pendaftar", pendaftar);
		return "recommended";
	}
}
