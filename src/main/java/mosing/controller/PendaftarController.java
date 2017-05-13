package mosing.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import mosing.model.JalurMasukModel;
import mosing.model.LPTerdahuluModel;
import mosing.model.PendaftarModel;
import mosing.model.PenyeleksianModel;
import mosing.model.NilaiModel;
import mosing.service.JalurMasukService;
import mosing.service.LPTerdahuluService;
import mosing.service.NilaiService;
import mosing.service.PendaftarService;
import mosing.service.PenyeleksianService;

@Controller
public class PendaftarController {

	@Autowired
	PendaftarService pendaftarDAO;

	@Autowired
	PenyeleksianService penyeleksianDAO;

	@Autowired
	JalurMasukService jalurMasukDAO;

	@Autowired
	LPTerdahuluService lptDAO;
	
	@Autowired
	NilaiService nilaiDAO;

	@RequestMapping("/pendaftar/{no_id}")
	public String add(Model model, @PathVariable(value = "no_id") String no_id) {
		PendaftarModel pendaftar = pendaftarDAO.selectPendaftar(no_id);

		if (pendaftar != null) {
			return "sudahdaftarseleksi";
		}
		model.addAttribute("no_id", no_id);
		return "form-registrasi2";
	}

	@RequestMapping("/pendaftar/submit")
	public String profileSubmit(@RequestParam(value = "no_id", required = false) String no_id,
			@RequestParam(value = "nama_id", required = false) String nama_id,
			@RequestParam(value = "nama_ijazah", required = false) String nama_ijazah,
			@RequestParam(value = "foto", required = false) String foto,
			@RequestParam(value = "no_hp", required = false) String no_hp,
			@RequestParam(value = "no_telp", required = false) String no_telp,
			@RequestParam(value = "nama_negara", required = false) String nama_negara,
			@RequestParam(value = "kewarganegaraan", required = false) String kewarganegaraan,
			@RequestParam(value = "alamat_tetap", required = false) String alamat_tetap,
			@RequestParam(value = "jenis_id", required = false) String jenis_id,
			@RequestParam(value = "alamat_sekarang", required = false) String alamat_sekarang,
			@RequestParam(value = "tgl_lahir", required = false) String tgl_lahir,
			@RequestParam(value = "nama_provinsi", required = false) String nama_provinsi,
			@RequestParam(value = "nama_kota", required = false) String nama_kota,
			@RequestParam(value = "jenis_kelamin", required = false) String jenis_kelamin,
			@RequestParam(value = "nama_lembaga", required = false) String nama_lembaga,
			@RequestParam(value = "jurusan", required = false) String jurusan) throws ParseException {

		if (jenis_kelamin.equalsIgnoreCase("Laki-laki"))
			jenis_kelamin = "1";
		else
			jenis_kelamin = "0";

		byte jk = Byte.parseByte(jenis_kelamin);
		DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		Date tanggal_lahir = format.parse(tgl_lahir);

		PendaftarModel pendaftar = new PendaftarModel(5, no_id, nama_id, nama_ijazah, foto, no_hp, no_telp, nama_negara,
				kewarganegaraan, alamat_tetap, jenis_id, alamat_sekarang, tanggal_lahir, nama_provinsi, nama_kota, jk,
				nama_lembaga, jurusan, 0);

		pendaftarDAO.addPendaftar(pendaftar);
		// return "success-datadiri";
		return "success-daftarseleksi";
	}

	@RequestMapping("/daftar-siswa")
	public String lihatDaftarSiswa(Model model) {
		List<PendaftarModel> pendaftarVerif = pendaftarDAO.selectAllPendaftarTerverifikasi();
		List<PendaftarModel> pendaftarNonVerif = pendaftarDAO.selectAllPendaftarTakTerverifikasi();
		List<JalurMasukModel> jalurUndangan = jalurMasukDAO.selectAllJalurUndangan();
		List<PenyeleksianModel> penyeleksian = penyeleksianDAO.selectAllPenyeleksian();
		model.addAttribute("jalurUndangan", jalurUndangan);
		model.addAttribute("penyeleksian", penyeleksian);
		model.addAttribute("pendaftarVerif", pendaftarVerif);
		model.addAttribute("pendaftarNonVerif", pendaftarNonVerif);
		return "list-siswa-ppkb";
		// List<PendaftarModel> allSiswa = pendaftarDAO.selectAllSiswa();
		// model.addAttribute("allSiswa", allSiswa);
		//
		// return "list-siswa-ppkb";
	}

	@RequestMapping("/data-pendaftar/submit")
	public String dataSubmit(Model model, @RequestParam(value = "no_id", required = false) String no_id,
			@RequestParam(value = "jalur_undangan", required = false) int jalur_undangan,
			@RequestParam(value = "nama_id", required = false) String nama_id,
			@RequestParam(value = "nama_ijazah", required = false) String nama_ijazah,
			@RequestParam(value = "jenis_id", required = false) String jenis_id,
			@RequestParam(value = "jenis_kelamin", required = false) String jenis_kelamin,
			@RequestParam(value = "nama_lembaga", required = false) String nama_lembaga,
			@RequestParam(value = "jurusan", required = false) String jurusan) throws ParseException {

		if (jenis_kelamin.equalsIgnoreCase("Laki-laki"))
			jenis_kelamin = "1";
		else
			jenis_kelamin = "0";

		byte jk = Byte.parseByte(jenis_kelamin);
		PendaftarModel pendaftar = new PendaftarModel(5, no_id, nama_id, nama_ijazah, null, null, null, null, null,
				null, jenis_id, null, null, null, null, jk, nama_lembaga, jurusan, 0);

		pendaftarDAO.addPendaftar(pendaftar);
		PendaftarModel pendaftar2 = pendaftarDAO.selectPendaftar(no_id);
		// return "success-datadiri";
		byte status = 0;
		byte status_rekomen = 0;
		PenyeleksianModel penyeleksian = new PenyeleksianModel(pendaftar2.getNo_daftar(), status, jalur_undangan, status_rekomen, null);
		penyeleksianDAO.addPenyeleksian(penyeleksian);
		model.addAttribute("pendaftar2", pendaftar2);
		if (pendaftar2.getJurusan().equalsIgnoreCase("IPA"))
			return "form-nilai-ipa";
		else
			return "form-nilai-ips";
	}

	@RequestMapping("/data-pendaftar/update/{no_id}")
	public String updateData(Model model, @PathVariable(value = "no_id") String no_id) {
		List<LPTerdahuluModel> allLPT = lptDAO.selectAllLPT();
		List<JalurMasukModel> jalurUndangan = jalurMasukDAO.selectAllJalurUndangan();
		model.addAttribute("jalurUndangan", jalurUndangan);
		model.addAttribute("allLPT", allLPT);
		PendaftarModel pendaftar = pendaftarDAO.selectPendaftar(no_id);
		if (pendaftar != null) {
			model.addAttribute("pendaftar", pendaftar);
			return "edit-siswa";
		} else {
			model.addAttribute("no_id", no_id);
			return "error-update";
		}
	}

	@RequestMapping(value = "/data-pendaftar/update/submit", method = RequestMethod.POST)
	public String dataUpdateSubmit(Model model, @RequestParam(value = "no_daftar", required = false) int no_daftar,
			@RequestParam(value = "no_id", required = false) String no_id,
			@RequestParam(value = "jalur_undangan", required = false) int jalur_undangan,
			@RequestParam(value = "nama_id", required = false) String nama_id,
			@RequestParam(value = "nama_ijazah", required = false) String nama_ijazah,
			@RequestParam(value = "jenis_id", required = false) String jenis_id,
			@RequestParam(value = "jenis_kelamin", required = false) String jenis_kelamin,
			@RequestParam(value = "nama_lembaga", required = false) String nama_lembaga,
			@RequestParam(value = "jurusan", required = false) String jurusan) throws ParseException {

		if (jenis_kelamin.equalsIgnoreCase("Laki-laki"))
			jenis_kelamin = "1";
		else
			jenis_kelamin = "0";

		byte jk = Byte.parseByte(jenis_kelamin);
		PendaftarModel pendaftar = new PendaftarModel(5, no_id, nama_id, nama_ijazah, null, null, null, null, null,
				null, jenis_id, null, null, null, null, jk, nama_lembaga, jurusan, no_daftar);

		pendaftarDAO.updateDataPendaftar(pendaftar);
		PendaftarModel pendaftar2 = pendaftarDAO.selectPendaftar(no_id);
		// PenyeleksianModel penyeleksian = new
		// PenyeleksianModel(pendaftar2.getNo_daftar(), status, jalur_undangan,
		// null);
		// penyeleksianDAO.addPenyeleksian(penyeleksian);
		model.addAttribute("pendaftar2", pendaftar2);
		return "success-update-data";
	}
	
	@RequestMapping("/detail-siswa/{no_id}")
	public String detailSiswa(Model model, @PathVariable(value = "no_id") String no_id) {
		// ganti jadi selectPPKB nih selectPendaftar
		PendaftarModel pendaftar = pendaftarDAO.selectPPKB(no_id);
		int no_daftar = pendaftarDAO.selectPPKB(no_id).getNo_daftar();
		List<NilaiModel> nilai = nilaiDAO.selectNilai(no_daftar);
		int kkm_mtk = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_mtk();
		int kkm_kimia = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_kimia();
		int kkm_fisika = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_fisika();
		int kkm_biologi = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_biologi();
		int kkm_sejarah = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_sejarah();
		int kkm_geografi = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_geografi();
		int kkm_ekonomi = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_ekonomi();
		int kkm_bindo = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_bindo();
		int kkm_bing = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_bing();
		model.addAttribute("pendaftar", pendaftar);
		model.addAttribute("nilai", nilai);
		model.addAttribute("kkm_mtk", kkm_mtk);
		model.addAttribute("kkm_kimia", kkm_kimia);
		model.addAttribute("kkm_fisika", kkm_fisika);
		model.addAttribute("kkm_biologi", kkm_biologi);
		model.addAttribute("kkm_sejarah", kkm_sejarah);
		model.addAttribute("kkm_geografi", kkm_geografi);
		model.addAttribute("kkm_ekonomi", kkm_ekonomi);
		model.addAttribute("kkm_bindo", kkm_bindo);
		model.addAttribute("kkm_bing", kkm_bing);
		if (pendaftar.getJurusan().equalsIgnoreCase("IPA"))
			return "detailSiswa-ipa";
		else
			return "detailSiswa-ips";
		
	}
}
