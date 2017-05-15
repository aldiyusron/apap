package mosing.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import mosing.model.FakultasModel;
import mosing.model.JalurMasukModel;
import mosing.model.PendaftarModel;
import mosing.model.ProdiTersediaModel;
import mosing.service.JalurMasukService;
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
	
	@Autowired
	JalurMasukService jalurMasukDAO;

	@RequestMapping("/acceptPendaftar")
	public String acceptPendaftar(Model model) {
		List<JalurMasukModel> jalurMasuk = jalurMasukDAO.selectAllJalurMasuk();
		model.addAttribute("allJalur", jalurMasuk);
		return "pilih-jalur-terima";
	}

	@RequestMapping("/view/fakultas/{id_jalur}")
	public String lihatFakultas(Model model, @PathVariable(value = "id_jalur") int id_jalur) {
		List<FakultasModel> fakultas = pfakultasDAO.selectAllFakultas();
		for (int i = 0; i < fakultas.size(); i++) {
			int id_fakultas = fakultas.get(i).getId_fakultas();
			List<ProdiTersediaModel> prodi = prodiDAO.selectAllProdiFak(id_fakultas);
			List<ProdiTersediaModel> prodiJalur = new ArrayList<ProdiTersediaModel>();
			for(int j = 0; j < prodi.size(); j++)
			{
				if(prodi.get(j).getId_jalur() == id_jalur)
				{
					prodiJalur.add(prodi.get(j));
				}
			}
			fakultas.get(i).setProdi(prodiJalur);
		}
		model.addAttribute("id_jalur", id_jalur);
		model.addAttribute("fakultas", fakultas);
		return "view-fakultasRecommending";
	}

	@RequestMapping("/view/pendaftar/{id_prodi}")
	public String rekomendasikan(Model model, @PathVariable(value = "id_prodi") int id_prodi) {
		List<PendaftarModel> pendaftar = pendaftarDAO.selectAllPendaftarNonRec(id_prodi);
		model.addAttribute("pendaftar", pendaftar);
		return "recommending";
	}

	@RequestMapping("/view/pendaftar/rec/{id_prodi}")
	public String rekomendasi(Model model, @PathVariable(value = "id_prodi") int id_prodi) {
		List<PendaftarModel> pendaftar = pendaftarDAO.selectAllPendaftarRec(id_prodi);
		model.addAttribute("pendaftar", pendaftar);
		return "recommended";
	}
}
