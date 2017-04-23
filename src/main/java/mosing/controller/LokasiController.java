package mosing.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import mosing.model.KotaModel;
import mosing.model.LokasiModel;
import mosing.model.ProvinsiModel;
import mosing.service.KotaService;
import mosing.service.LokasiService;
import mosing.service.ProvinsiService;

@Controller
public class LokasiController {

	@Autowired
	LokasiService lokasiDAO;
	
	@Autowired
	ProvinsiService provinsiDAO;
	
	@Autowired
	KotaService kotaDAO;
	
	@RequestMapping("/detail-ujian")
	public String lihatDaftarLokasi(Model model) {
		List<LokasiModel> allLokasi = lokasiDAO.selectAllLokasi();
		model.addAttribute("allLokasi", allLokasi);

		return "view-all-lokasi";
	}

	@RequestMapping("/detail-ujian/add")
	public String tambahLokasi(Model model) {
		List<ProvinsiModel> allProvinsi = provinsiDAO.selectAllProvinsi();
		List<KotaModel> allKota = kotaDAO.selectKotaIndo();
		model.addAttribute("allProvinsi", allProvinsi);
		model.addAttribute("allKota", allKota);
		return "add-lokasi";
	}

	@RequestMapping("/detail-ujian/add/submit")
	public String tambahLokasiSubmit(@RequestParam(value = "alamat", required = false) String alamat,
			@RequestParam(value = "nama_lokasi", required = false) String nama_lokasi,
			@RequestParam(value = "no_telp", required = false) String no_telp,
			@RequestParam(value = "nama_provinsi", required = false) String nama_provinsi,
			@RequestParam(value = "nama_kota", required = false) String nama_kota,
			@RequestParam(value = "kuota_peng", required = false) int kuota_peng,
			@RequestParam(value = "kuota_pendaftar", required = false) int kuota_pendaftar) {
		
		LokasiModel lokasi = new LokasiModel(0, alamat, no_telp, nama_lokasi, nama_provinsi, nama_kota, kuota_peng,
				kuota_pendaftar, 1);
		lokasiDAO.addLokasiUjian(lokasi);
		System.out.println(lokasi.getNama_provinsi());

		return "success-add-lokasi";
	}

	@GetMapping("/detail-ujian/delete/{id_lokasi}")
	public String hapusLokasi(Model model, @PathVariable(value = "id_lokasi") int id_lokasi) {
		LokasiModel lokasi = lokasiDAO.selectLokasi(id_lokasi);
		if(lokasi != null) {
			model.addAttribute("lokasi", lokasi);
			return "delete-lokasi";
		}
		else
			model.addAttribute("id_lokasi", id_lokasi);
			return "error";
	}
	
	@PostMapping("/detail-ujian/delete/submit")
	public String hapusLokasiKonfirmasi(@ModelAttribute LokasiModel lokasi) {
		lokasiDAO.deleteLokasiUjian(lokasi);

		return "success-delete-lokasi";
	}

	@GetMapping("/detail-ujian/update/{id_lokasi}")
	public String updateLokasi(Model model, @PathVariable(value = "id_lokasi") int id_lokasi) {
		LokasiModel lokasi = lokasiDAO.selectLokasi(id_lokasi);
		if (lokasi != null) {
			model.addAttribute("lokasi", lokasi);
			return "update-lokasi";
		} else {
			model.addAttribute("id_lokasi", id_lokasi);
			return "error";
		}
	}

	@PostMapping("/detail-ujian/update/submit")
	public String updateLokasiSubmit(@ModelAttribute LokasiModel lokasi) {
		lokasiDAO.updateLokasiUjian(lokasi);
		return "success-update-lokasi";
	}
}
