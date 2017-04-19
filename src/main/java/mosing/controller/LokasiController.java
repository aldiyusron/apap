package mosing.controller;

import java.text.ParseException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import mosing.model.LokasiModel;
import mosing.service.LokasiService;

@Controller
public class LokasiController {

	@Autowired
	LokasiService lokasiDAO;

	@RequestMapping("/lokasi-ujian")
	public String lihatDaftarLokasi(Model model) {
		List<LokasiModel> allLokasi = lokasiDAO.selectAllLokasi();
		model.addAttribute("allLokasi", allLokasi);

		return "view-all-lokasi";
	}

	@RequestMapping("/lokasi-ujian/add")
	public String tambahLokasi() {
		return "add-lokasi";
	}

	@RequestMapping("/lokasi-ujian/add/submit")
	public String tambahLokasiSubmit(@RequestParam(value = "alamat", required = false) String alamat,
			@RequestParam(value = "nama_lokasi", required = false) String nama_lokasi,
			@RequestParam(value = "no_telp", required = false) String no_telp,
			@RequestParam(value = "nama_provinsi", required = false) String nama_provinsi,
			@RequestParam(value = "nama_kota", required = false) String nama_kota,
			@RequestParam(value = "kuota_peng", required = false) int kuota_peng,
			@RequestParam(value = "kuota_pendaftar", required = false) int kuota_pendaftar) throws ParseException {
		LokasiModel lokasi = new LokasiModel(null, alamat, nama_lokasi, no_telp, nama_provinsi, nama_kota, kuota_peng,
				kuota_pendaftar, 1);
		lokasiDAO.addLokasiUjian(lokasi);

		return "success-add-lokasi";
	}
}
