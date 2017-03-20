package mosing.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import mosing.model.LokasiModel;
import mosing.model.PengawasUjianModel;
import mosing.service.LokasiService;
import mosing.service.PengawasUjianService;

@Controller
public class PengawasUjianController {

	@Autowired
	PengawasUjianService pengawasDAO;

	@Autowired
	LokasiService lokasiDAO;

	@RequestMapping("/pengawas/{username}")
	public String addPengawas(Model model, @PathVariable(value = "username") String username) {
		List<LokasiModel> listLokasi = lokasiDAO.selectAllLokasi();
		model.addAttribute("listLokasi", listLokasi);
		model.addAttribute("username", username);
		return "form-registrasi3";
	}

	@RequestMapping("/pengawas/submit")
	public String addSubmit(@RequestParam(value = "username", required = false) String username,
			@RequestParam(value = "jabatan", required = false) String jabatan,
			@RequestParam(value = "nama", required = false) String nama,
			@RequestParam(value = "lokasi", required = false) String lokasi) {
		
//		LokasiModel lokasi_pengawas = lokasiDAO.selectLokasi(lokasi);
		PengawasUjianModel pengawas = new PengawasUjianModel(username, false, jabatan, nama, lokasi);
		pengawasDAO.addPengawas(pengawas);
		return "success-datadiri";
	}
}
