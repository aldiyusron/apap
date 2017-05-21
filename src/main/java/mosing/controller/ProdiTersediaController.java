package mosing.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import mosing.model.FakultasModel;
import mosing.model.ProdiTersediaModel;
import mosing.service.DetailUjianService;
import mosing.service.FakultasService;
import mosing.service.JalurMasukService;
import mosing.service.KotaService;
import mosing.service.ProdiTersediaService;

@Controller
public class ProdiTersediaController {

	@Autowired
	ProdiTersediaService prodiTersediaDAO;

	@Autowired
	FakultasService fakultasDAO;

	@Autowired
	KotaService kotaDAO;

	@Autowired
	DetailUjianService detailUjianDAO;
	
	@Autowired
	JalurMasukService jalurMasukDAO;

//	@RequestMapping("/detail-ujian")
//	public String lihatDaftarLokasi(Model model) {
//		List<LokasiModel> allLokasi = lokasiDAO.selectAllLokasi();
//		model.addAttribute("allLokasi", allLokasi);
//		return "view-all-lokasi";
//	}

	@RequestMapping("/prodi-tersedia/add/{id_jalur}")
	public String addProdi(Model model, @PathVariable(value = "id_jalur") int id_jalur) {
		List<FakultasModel> allFakultas = fakultasDAO.selectAllFakultas();
		model.addAttribute("allFakultas", allFakultas);
		return "form-addprodi";
	}

	@RequestMapping("/prodi-tersedia/add/submit/{id_jalur}")
	public String addProdiSubmit(Model model, @PathVariable(value = "id_jalur") int id_jalur,
			@RequestParam(value = "nama_prodi", required = false) String nama_prodi,
			@RequestParam(value = "daya_tampung", required = false) int daya_tampung,
			@RequestParam(value = "id_fakultas", required = false) int id_fakultas) {
		//JalurMasukModel jalur = jalurMasukDAO.selectJalurMasuk(id_jalur);
		model.addAttribute("id_jalur", id_jalur);
		ProdiTersediaModel prodi = new ProdiTersediaModel(0, nama_prodi, daya_tampung, id_fakultas, id_jalur, 1);
		prodiTersediaDAO.addProdi(prodi);

		return "success-addprodi";
	}

	@RequestMapping(value = "/prodi-tersedia/delete/{id_prodi}", method = RequestMethod.GET)
	public String deleteProdi(Model model, @PathVariable(value = "id_prodi") int id_prodi) {
		ProdiTersediaModel prodi = prodiTersediaDAO.selectProdi(id_prodi);
		model.addAttribute("prodi", prodi);

		return "konfirmasi-deleteprodi";
	}

	@RequestMapping(value = "/prodi-tersedia/delete/submit/{id_prodi}")
	public String deleteProdiSubmit(Model model, @PathVariable(value = "id_prodi") int id_prodi) {
		ProdiTersediaModel prodi = prodiTersediaDAO.selectProdi(id_prodi);
		int id_jalur = prodiTersediaDAO.selectProdi(id_prodi).getId_jalur();
		model.addAttribute("id_jalur", id_jalur);
		model.addAttribute("prodi", prodi);
		prodiTersediaDAO.deleteProdi(prodi);

		return "success-deleteprodi";
	}

	@RequestMapping("/prodi-tersedia/update/{id_prodi}")
	public String updateProdi(Model model, @PathVariable(value = "id_prodi") int id_prodi) {
		ProdiTersediaModel prodi = prodiTersediaDAO.selectProdi(id_prodi);
		List<FakultasModel> allFakultas = fakultasDAO.selectAllFakultas();
		model.addAttribute("prodi", prodi);
		model.addAttribute("allFakultas", allFakultas);
		return "form-updateprodi";
	}

	@RequestMapping(value = "/prodi-tersedia/update/submit/{id_prodi}", method = RequestMethod.POST)
	public String updateLokasiSubmit(Model model, @PathVariable(value = "id_prodi") int id_prodi,
			@RequestParam(value = "nama_prodi", required = false) String nama_prodi,
			@RequestParam(value = "daya_tampung", required = false) int daya_tampung,
			@RequestParam(value = "id_fakultas", required = false) int id_fakultas) {
		ProdiTersediaModel prodi = prodiTersediaDAO.selectProdi(id_prodi);
		int id_jalur = prodiTersediaDAO.selectProdi(id_prodi).getId_jalur();
		model.addAttribute("id_jalur", id_jalur);
		ProdiTersediaModel prodiNew = new ProdiTersediaModel(id_prodi, nama_prodi, daya_tampung, id_fakultas, prodi.getId_jalur(), 1);
		prodiTersediaDAO.updateProdi(prodiNew);
		return "success-updateprodi";
	}
}