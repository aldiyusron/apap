package mosing.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import mosing.model.ListStrings;
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
			@RequestParam(value = "no_hp", required = false) String no_hp,
			@RequestParam(value = "pindah_bool", required = false) int pindah_bool,
			@RequestParam(value = "lokasi", required = false) int lokasi) {

		LokasiModel lokasimodel = lokasiDAO.selectLokasi(lokasi);
		UserAdmisiModel user = userDAO.selectUser(username);
		int iduser = Integer.parseInt(user.getId_user());
		PengawasUjianModel pengawas = new PengawasUjianModel(iduser, 0, jabatan, nama, no_hp,
				lokasimodel.getId_lokasi(), pindah_bool, 1);
		pengawasDAO.addPengawas(pengawas);
		return "success-daftarpengawas";
	}

	@RequestMapping("/seleksi-pengawas")
	public String lihatDaftarLokasiPengawas(Model model) {
		List<LokasiModel> allLokasi = lokasiDAO.selectAllLokasi();
		model.addAttribute("allLokasi", allLokasi);

		return "view-alllokasiseleksi";
	}

	@RequestMapping("/seleksi-pengawas/view/{id_lokasi}")
	public String lihatDaftarPengawas(Model model, @PathVariable(value = "id_lokasi") int id_lokasi) {
		LokasiModel lokasi = lokasiDAO.selectLokasi(id_lokasi);

		if (lokasi != null) {
			model.addAttribute("lokasi", lokasi);
			List<PengawasUjianModel> listPengawas = pengawasDAO.selectPengawasUjianLokasi(id_lokasi);
			model.addAttribute("listPengawas", listPengawas);
			model.addAttribute("statusSubmit", new ListStrings());
			return "view-seleksipengawas";
		} else {
			model.addAttribute("id_lokasi", id_lokasi);
			return "viewnotfound-seleksipengawas";
		}
	}

	@RequestMapping(value = "/seleksi-pengawas/sukses")
	public String suksesSeleksi(@ModelAttribute(value = "statusSubmit") @Valid ListStrings statusSubmit,
			BindingResult bindingResultStatus, Model model,
			@RequestParam(value = "id_lokasi", required = false) int id_lokasi) {
		System.out.println("size:" + statusSubmit.getStrings().size());
		System.out.println("binding result:" + bindingResultStatus.getModel().toString());
		System.out.println(statusSubmit.getStrings().get(0));
		for (int i = 0; i < statusSubmit.getStrings().size(); i++) {
			if (statusSubmit.getStrings().get(i) != null) {
				String nomor = statusSubmit.getStrings().get(i);
				int id_user = Integer.parseInt(nomor);
				pengawasDAO.terimaPengawas(id_user);
			}
		}
		List<PengawasUjianModel> listPengawas = pengawasDAO.selectPengawasUjianLokasi(id_lokasi);
		model.addAttribute("listPengawas", listPengawas);
		LokasiModel lokasi = lokasiDAO.selectLokasi(id_lokasi);
		model.addAttribute("lokasi", lokasi);
		return "success-seleksipengawas";
	}
}
