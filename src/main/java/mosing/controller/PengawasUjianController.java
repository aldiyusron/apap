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
import mosing.model.UserAdmisiModel;
import mosing.service.LokasiService;
import mosing.service.PengawasUjianService;
import mosing.service.UserAdmisiService;

@Controller
public class PengawasUjianController {

	@Autowired
	PengawasUjianService pengawasDAO;

	@Autowired
	UserAdmisiService userDAO;

	@Autowired
	LokasiService lokasiDAO;

	@RequestMapping("/pengawas/{username}")
	public String addPengawas(Model model, @PathVariable(value = "username") String username) {
		PengawasUjianModel pengawas = pengawasDAO.selectPengawas(username);
		if (pengawas != null) {
			return "sudahdaftarseleksi";
		}
		List<LokasiModel> listLokasi = lokasiDAO.selectAllLokasi();
		model.addAttribute("listLokasi", listLokasi);
		model.addAttribute("username", username);
		return "form-registrasi3";
	}

	@RequestMapping("/pengawas/submit")
	public String addSubmit(@RequestParam(value = "username", required = false) String username,
			@RequestParam(value = "jabatan", required = false) String jabatan,
			@RequestParam(value = "nama", required = false) String nama,
			@RequestParam(value = "lokasi", required = false) int lokasi) {
		
		LokasiModel lokasimodel = lokasiDAO.selectLokasi(lokasi);
		UserAdmisiModel user = userDAO.selectUser(username);
		int iduser = Integer.parseInt(user.getId_user());
		PengawasUjianModel pengawas = new PengawasUjianModel(iduser, false, jabatan, nama,
				lokasimodel.getId_lokasi());
		pengawasDAO.addPengawas(pengawas);
		return "success-daftarpengawas";
	}
}
