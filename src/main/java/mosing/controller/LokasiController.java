package mosing.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import mosing.model.KotaModel;
import mosing.model.LokasiModel;
import mosing.model.ProvinsiModel;
import mosing.service.DetailUjianService;
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

	@Autowired
	DetailUjianService detailUjianDAO;

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
			@RequestParam(value = "no_telp", required = false) String no_telp,
			@RequestParam(value = "nama_lokasi", required = false) String nama_lokasi,
			@RequestParam(value = "nama_provinsi", required = false) String nama_provinsi,
			@RequestParam(value = "nama_kota", required = false) String nama_kota,
			@RequestParam(value = "kuota_peng", required = false) int kuota_peng,
			@RequestParam(value = "kuota_pendaftar", required = false) int kuota_pendaftar) {

		LokasiModel lokasi = new LokasiModel(0, alamat, no_telp, nama_lokasi, nama_provinsi, nama_kota, kuota_peng,
				kuota_pendaftar, 1);
		lokasiDAO.addLokasiUjian(lokasi);

		return "success-add-lokasi";
	}

	@RequestMapping(value = "/detail-ujian/delete/{id_lokasi}", method = RequestMethod.GET)
	public String hapusLokasi(Model model, @PathVariable(value = "id_lokasi") int id_lokasi) {
		LokasiModel lokasi = lokasiDAO.selectLokasi(id_lokasi);
		model.addAttribute("lokasi", lokasi);

		return "delete-lokasi";
	}

	@RequestMapping(value = "/detail-ujian/delete/submit/{id_lokasi}")
	public String hapusLokasiSubmit(Model model, @PathVariable(value = "id_lokasi") int id_lokasi) {
		LokasiModel lokasi = lokasiDAO.selectLokasi(id_lokasi);
		model.addAttribute("lokasi", lokasi);
		lokasiDAO.deleteLokasiUjian(lokasi);

		return "success-delete-lokasi";
	}

	@RequestMapping("/detail-ujian/update/{id_lokasi}")
	public String updateLokasi(Model model, @PathVariable(value = "id_lokasi") int id_lokasi) {
		LokasiModel lokasi = lokasiDAO.selectLokasi(id_lokasi);
		List<ProvinsiModel> allProvinsi = provinsiDAO.selectAllProvinsi();
		List<KotaModel> allKota = kotaDAO.selectKotaIndo();
		model.addAttribute("lokasi", lokasi);
		model.addAttribute("allProvinsi", allProvinsi);
		model.addAttribute("allKota", allKota);
		return "update-lokasi";
	}

	@RequestMapping(value = "/detail-ujian/update/submit/{id_lokasi}", method = RequestMethod.POST)
	public String updateLokasiSubmit(@PathVariable(value = "id_lokasi") int id_lokasi,
			@RequestParam(value = "alamat", required = false) String alamat,
			@RequestParam(value = "no_telp", required = false) String no_telp,
			@RequestParam(value = "nama_lokasi", required = false) String nama_lokasi,
			@RequestParam(value = "nama_provinsi", required = false) String nama_provinsi,
			@RequestParam(value = "nama_kota", required = false) String nama_kota,
			@RequestParam(value = "kuota_peng", required = false) int kuota_peng,
			@RequestParam(value = "kuota_pendaftar", required = false) int kuota_pendaftar) {

		LokasiModel lokasi = new LokasiModel(id_lokasi, alamat, no_telp, nama_lokasi, nama_provinsi, nama_kota,
				kuota_peng, kuota_pendaftar, 1);
		lokasiDAO.updateLokasiUjian(lokasi);
		return "success-update-lokasi";
	}
}