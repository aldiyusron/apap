package mosing.controller;

import java.text.ParseException;
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

import mosing.model.LokasiModel;
import mosing.service.LokasiService;

@Controller
public class LokasiController {

	@Autowired
	LokasiService lokasiDAO;

	@RequestMapping("/detail-ujian")
	public String lihatDaftarLokasi(Model model) {
		List<LokasiModel> allLokasi = lokasiDAO.selectAllLokasi();
		model.addAttribute("allLokasi", allLokasi);

		return "view-all-lokasi";
	}

	@RequestMapping("/detail-ujian/add")
	public String tambahLokasi() {
		return "add-lokasi";
	}

	@RequestMapping("/detail-ujian/add/submit")
	public String tambahLokasiSubmit(@RequestParam(value = "alamat", required = false) String alamat,
			@RequestParam(value = "nama_lokasi", required = false) String nama_lokasi,
			@RequestParam(value = "no_telp", required = false) String no_telp,
			@RequestParam(value = "nama_provinsi", required = false) String nama_provinsi,
			@RequestParam(value = "nama_kota", required = false) String nama_kota,
			@RequestParam(value = "kuota_peng", required = false) int kuota_peng,
			@RequestParam(value = "kuota_pendaftar", required = false) int kuota_pendaftar) throws ParseException {
		LokasiModel lokasi = new LokasiModel(0, alamat, no_telp, nama_lokasi, nama_provinsi, nama_kota, kuota_peng,
				kuota_pendaftar, 1);
		lokasiDAO.addLokasiUjian(lokasi);

		return "success-add-lokasi";
	}

	@RequestMapping("/detail-ujian/delete/{id_lokasi}")
	public String hapusLokasi(Model model, @PathVariable(value = "id_lokasi") int id_lokasi) {
		LokasiModel lokasi = lokasiDAO.selectLokasi(id_lokasi);
		lokasiDAO.deleteLokasiUjian(lokasi);

		return "delete-lokasi";
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

	@PostMapping("/detail-ujian/update")
	public String updateLokasiSubmit(@ModelAttribute LokasiModel lokasi) {
		lokasiDAO.updateLokasiUjian(lokasi);
		return "success-update-lokasi";
	}
}
