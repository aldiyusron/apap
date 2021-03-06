package mosing.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.ResponseStatus;
import mosing.model.CalonMahasiswaModel;
import mosing.model.DaftarPilihanModel;
import mosing.model.DetailUjianModel;
import mosing.model.FakultasModel;
import mosing.model.JalurMasukModel;
import mosing.model.KotaModel;
import mosing.model.LPTerdahuluModel;
import mosing.model.PendaftarModel;
import mosing.model.PenyeleksianModel;
import mosing.model.NilaiModel;
import mosing.model.ProdiTersediaModel;
import mosing.model.ProvinsiModel;
import mosing.model.RiwayatPendaftaranModel;
import mosing.model.UserAdmisiModel;
import mosing.service.BerkasService;
import mosing.service.CalonMahasiswaService;
import mosing.service.DetailUjianService;
import mosing.service.FakultasService;
import mosing.service.FotoService;
import mosing.service.JalurMasukService;
import mosing.service.KotaService;
import mosing.service.LPTerdahuluService;
import mosing.service.LokasiService;
import mosing.service.NilaiService;
import mosing.service.PendaftarService;
import mosing.service.PenyeleksianService;
import mosing.service.ProdiTersediaService;
import mosing.service.ProdiService;
import mosing.service.ProvinsiService;
import mosing.service.RiwayatPendaftaranService;
import mosing.service.UserAdmisiService;

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
	
	@Autowired
	CalonMahasiswaService calonMahasiswaDAO;
	
	@Autowired
	ProdiTersediaService prodiTersediaDAO;

	@Autowired
	UserAdmisiService userDAO;

	@Autowired
	ProdiTersediaService prodiDAO;

	@Autowired
	JalurMasukService jalurmasukDAO;

	@Autowired
	ProvinsiService provinsiDAO;

	@Autowired
	KotaService kotaDAO;
	
	@Autowired
	FotoService fotoDAO;

	@Autowired
	FakultasService fakultasDAO;

	@Autowired
	BerkasService berkasDAO;

	@Autowired
	DetailUjianService detailDAO;

	@Autowired
	LokasiService lokasiDAO;

	@Autowired
	RiwayatPendaftaranService riwayatDAO;

	@RequestMapping("/pendaftar/uploadFoto/{username}")
	public String uploadFoto(Model model, @PathVariable(value = "username") String username) {
		PendaftarModel pendaftar = pendaftarDAO.selectPendaftar2(username);
		model.addAttribute("pendaftar", pendaftar);
		return "uploadForm";
	}

	@RequestMapping("/pendaftar/uploadRapor/{username}")
	public String uploadRapor(Model model, @PathVariable(value = "username") String username) {
		PendaftarModel pendaftar = pendaftarDAO.selectPendaftar2(username);
		PenyeleksianModel penyeleksian = penyeleksianDAO.selectPenyeleksian2(pendaftar.getNo_daftar());
		model.addAttribute("pendaftar", pendaftar);
		model.addAttribute("penyeleksian", penyeleksian);
		return "uploadBerkas";
	}

	@RequestMapping("/pendaftar/uploadRapor/{username}/submit")
	public String uploadRaporSubmit(Model model, @RequestParam(value = "rapor", required = false) MultipartFile rapor,
			@PathVariable(value = "username") String username) throws IOException {

		PendaftarModel pendaftar = pendaftarDAO.selectPendaftar2(username);
		PenyeleksianModel penyeleksian = penyeleksianDAO.selectPenyeleksian2(pendaftar.getNo_daftar());
		penyeleksian.setFileBerkas(rapor);
		berkasDAO.insert(penyeleksian);

		model.addAttribute("penyeleksian", penyeleksian);
		return "redirect:/pendaftar/uploadRapor/" + username;
	}

	@RequestMapping("/pendaftar/verifikasi/nilai/{username}")
	public String verifNilai(Model model, @PathVariable(value = "username") String username,
			@RequestParam(value = "email", required = false) String email,
			@RequestParam(value = "no_hp", required = false) String no_hp,
			@RequestParam(value = "no_telp", required = false) String no_telp,
			@RequestParam(value = "nama_negara", required = false) String nama_negara,
			@RequestParam(value = "kewarganegaraan", required = false) String kewarganegaraan,
			@RequestParam(value = "alamat_tetap", required = false) String alamat_tetap,
			@RequestParam(value = "alamat_sekarang", required = false) String alamat_sekarang,
			@RequestParam(value = "tgl_lahir", required = false) String tgl_lahir,
			@RequestParam(value = "nama_provinsi", required = false) String nama_provinsi,
			@RequestParam(value = "nama_kota", required = false) String nama_kota) throws ParseException {

		UserAdmisiModel user = userDAO.selectUser(username);
		user.setEmail(email);
		userDAO.updateEmail(user);
		DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		Date tanggal_lahir = format.parse(tgl_lahir);
		// ganti jadi selectPPKB nih selectPendaftar
		PendaftarModel pendaftar = pendaftarDAO.selectPendaftar2(username);
		pendaftar.setNo_hp(no_hp);
		pendaftar.setNo_telp(no_telp);
		pendaftar.setAlamat_sekarang(alamat_sekarang);
		pendaftar.setAlamat_tetap(alamat_tetap);
		pendaftar.setKewarganegaraan(kewarganegaraan);
		pendaftar.setNama_kota(nama_kota);
		pendaftar.setNama_provinsi(nama_provinsi);
		pendaftar.setNama_negara(nama_negara);
		pendaftar.setTgl_lahir(tanggal_lahir);
		pendaftarDAO.updateDataDiriLengkap(pendaftar);

		// PendaftarModel pendaftar = pendaftarDAO.selectPPKB(no_id);
		int no_daftar = pendaftar.getNo_daftar();
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
			return "detailNilai-ipa";
		else
			return "detailNilai-ips";
	}

	@RequestMapping("/pendaftar/uploadFoto/{username}/submit")
	public String uploadFotoSubmit(Model model, @RequestParam(value = "foto", required = false) MultipartFile foto,
			@PathVariable(value = "username") String username) throws IOException {

		PendaftarModel pendaftar = pendaftarDAO.selectPendaftar2(username);
		pendaftar.setPhoto(foto);
		fotoDAO.insert(pendaftar);

		model.addAttribute("pendaftar", pendaftar);
		return "redirect:/pendaftar/uploadFoto/" + username;
	}

	@RequestMapping("/pendaftar/registration/done")
	public String uploadFotoSuccess() {
		return "success-daftarseleksi";
	}

	@RequestMapping("/pendaftar/rencanastudi")
	public String profileSubmit(Model model, @RequestParam(value = "id_jalur", required = false) int id_jalur,
			@RequestParam(value = "username", required = false) String username,
			@RequestParam(value = "jenis_id", required = false) String jenis_id,
			@RequestParam(value = "no_id", required = false) String no_id,
			@RequestParam(value = "nama_id", required = false) String nama_id,
			@RequestParam(value = "nama_ijazah", required = false) String nama_ijazah,
			@RequestParam(value = "no_hp", required = false) String no_hp,
			@RequestParam(value = "no_telp", required = false) String no_telp,
			@RequestParam(value = "nama_negara", required = false) String nama_negara,
			@RequestParam(value = "kewarganegaraan", required = false) String kewarganegaraan,
			@RequestParam(value = "alamat_tetap", required = false) String alamat_tetap,
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

		UserAdmisiModel user = userDAO.selectUser(username);
		byte jk = Byte.parseByte(jenis_kelamin);
		DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		Date tanggal_lahir = format.parse(tgl_lahir);
		int id_user = Integer.parseInt(user.getId_user());
		PendaftarModel pendaftar = new PendaftarModel(id_user, no_id, nama_id, nama_ijazah, null, null, no_hp, no_telp,
				nama_negara, kewarganegaraan, alamat_tetap, jenis_id, alamat_sekarang, tanggal_lahir, nama_provinsi,
				nama_kota, jk, 0, nama_lembaga, jurusan, 0);

		pendaftarDAO.addPendaftar(pendaftar);
		PendaftarModel pendaftarSeleksi = pendaftarDAO.selectPendaftar2(username);
		Byte status = Byte.parseByte("0");
		byte status_rekomen = 0;
		int no_daftar = pendaftarSeleksi.getNo_daftar();
		PenyeleksianModel penyeleksian = new PenyeleksianModel(no_daftar, status, id_jalur, status_rekomen, null, null);
		penyeleksianDAO.addPenyeleksian(penyeleksian);

		List<ProdiTersediaModel> prodiTersedia = prodiDAO.selectAllProdi(id_jalur);
		model.addAttribute("prodiTersedia", prodiTersedia);
		model.addAttribute("no_daftar", no_daftar);
		model.addAttribute("id_jalur", id_jalur);
		model.addAttribute("username", username);
		return "formrencanastudi";
	}

	@RequestMapping("/pendaftar/rencanastudi/submit")
	public String rencanaStudiSubmit(Model model, @RequestParam(value = "username", required = false) String username,
			@RequestParam(value = "no_daftar", required = false) int no_daftar,
			@RequestParam(value = "id_jalur", required = false) int id_jalur,
			@RequestParam(value = "pilihan1", required = false) int pilihan1,
			@RequestParam(value = "pilihan2", required = false) int pilihan2,
			@RequestParam(value = "pilihan3", required = false) int pilihan3,
			@RequestParam(value = "pilihan4", required = false) int pilihan4,
			@RequestParam(value = "pilihan5", required = false) int pilihan5,
			@RequestParam(value = "pilihan6", required = false) int pilihan6) {
		JalurMasukModel jalurmasuk = jalurmasukDAO.selectJalurMasuk(id_jalur);
		List<Integer> pilihanProdi = new ArrayList<Integer>();
		pilihanProdi.add(pilihan1);
		pilihanProdi.add(pilihan2);
		pilihanProdi.add(pilihan3);
		pilihanProdi.add(pilihan4);
		pilihanProdi.add(pilihan5);
		pilihanProdi.add(pilihan6);
		for (int i = 0; i < pilihanProdi.size(); i++) {
			int prodi = Integer.parseInt(pilihanProdi.get(i).toString());
			if (prodi != 0) {
				DaftarPilihanModel daftarPilihan = new DaftarPilihanModel(no_daftar, jalurmasuk.getNama_jenjang(),
						jalurmasuk.getNama_program(), prodi, i + 1);
				pendaftarDAO.addDaftarPilihan(daftarPilihan);
			}
		}
		String no_ujian = "";
		if (no_daftar < 10) {
			no_ujian = "00000" + no_daftar;
		} else if (no_daftar < 100) {
			no_ujian = "0000" + no_daftar;
		} else if (no_daftar < 1000) {
			no_ujian = "000" + no_daftar;
		} else if (no_daftar < 10000) {
			no_ujian = "00" + no_daftar;
		} else if (no_daftar < 100000) {
			no_ujian = "0" + no_daftar;
		} else {
			no_ujian = "" + no_daftar;
		}

		int id_lokasi = 0;
		for (int i = 0; i < jalurmasuk.getListLokasi().size(); i++) {
			int kuota_pend = jalurmasuk.getListLokasi().get(i).getKuota_pendaftar();
			if (kuota_pend > 0) {
				id_lokasi = jalurmasuk.getListLokasi().get(i).getId_lokasi();
				kuota_pend = kuota_pend - 1;
				jalurmasuk.getListLokasi().get(i).setKuota_pendaftar(kuota_pend);
				lokasiDAO.updateLokasiUjian(jalurmasuk.getListLokasi().get(i));
			}
		}
		DetailUjianModel detail = new DetailUjianModel(no_daftar, no_ujian, id_jalur, id_lokasi,
				jalurmasuk.getWaktu_ujian());
		detailDAO.addDetail(detail);
		int year = Calendar.getInstance().get(Calendar.YEAR);
		String tahun = String.valueOf(year);
		RiwayatPendaftaranModel riwayat = new RiwayatPendaftaranModel(no_daftar, tahun, id_jalur,
				jalurmasuk.getNama_jenjang(), jalurmasuk.getNama_program());
		riwayatDAO.addRiwayat(riwayat);
		model.addAttribute("username", username);
		return "success-rencanastudi";
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
			@RequestParam(value = "id_prodi", required = false) int id_prodi,
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
		JalurMasukModel jalurPPKB = jalurMasukDAO.selectJalurMasuk(4);
		List<UserAdmisiModel> allUser = userDAO.selectAllUser();
		String id = allUser.get(allUser.size() - 1).getId_user();
		int latestID = Integer.parseInt(id);
		int newID = latestID + 1;

		boolean whiteSpace = nama_id.contains(" ");
		String username = "";
		if (whiteSpace == false) {
			username = nama_id.toLowerCase();
		} else {
			String[] parts = nama_id.split("\\s+");
			username = (parts[0] + parts[1]).toLowerCase();

		}
		String alphabet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
		int n = alphabet.length();

		Random random = new Random();

		String passwordFinal = "";
		char password;
		for (int i = 0; i < 20; i++) {
			password = alphabet.charAt(random.nextInt(n));
			passwordFinal = passwordFinal + Character.toString(password);
		}

		UserAdmisiModel newUser = new UserAdmisiModel(null, username, passwordFinal, null, "ROLE_PEND");
		PendaftarModel pendaftar = new PendaftarModel(newID, no_id, nama_id, nama_ijazah, null, null, null, null, null,
				null, null, jenis_id, null, null, null, null, jk, 0, nama_lembaga, jurusan, 0);

		userDAO.addUser(newUser);
		pendaftarDAO.addPendaftar(pendaftar);
		PendaftarModel pendaftar2 = pendaftarDAO.selectPendaftar(no_id);
		// return "success-datadiri";
		byte status = 0;
		byte status_rekomen = 0;
		PenyeleksianModel penyeleksian = new PenyeleksianModel(pendaftar2.getNo_daftar(), status, 4, status_rekomen,
				null, null);
		penyeleksianDAO.addPenyeleksian(penyeleksian);
		DaftarPilihanModel pilihan = new DaftarPilihanModel(pendaftar2.getNo_daftar(), jalurPPKB.getNama_jenjang(),
				jalurPPKB.getNama_program(), id_prodi, 1);
		pendaftarDAO.addDaftarPilihan(pilihan);
		int year = Calendar.getInstance().get(Calendar.YEAR);
		String tahun = String.valueOf(year);
		RiwayatPendaftaranModel riwayat = new RiwayatPendaftaranModel(pendaftar2.getNo_daftar(), tahun, 4,
				jalurPPKB.getNama_jenjang(), jalurPPKB.getNama_program());
		riwayatDAO.addRiwayat(riwayat);
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
		JalurMasukModel jalurPPKB = jalurMasukDAO.selectJalurMasuk(4);
		List<ProdiTersediaModel> prodi = jalurPPKB.getListProdi();
		model.addAttribute("jalurUndangan", jalurUndangan);
		model.addAttribute("allLPT", allLPT);
		model.addAttribute("prodi", prodi);
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
	public String dataUpdateSubmit(Model model, @RequestParam(value = "no_id", required = false) String no_id,
			@RequestParam(value = "id_prodi", required = false) int id_prodi,
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

		PendaftarModel pendaftar2 = pendaftarDAO.selectPendaftar(no_id);
		PendaftarModel pendaftar = new PendaftarModel(pendaftar2.getId_user(), no_id, nama_id, nama_ijazah, null, null,
				null, null, null, null, null, jenis_id, null, null, null, null, jk, 0, nama_lembaga, jurusan, 0);
		pendaftarDAO.updateDataPendaftar(pendaftar);
		pendaftar2 = pendaftarDAO.selectPendaftar(no_id);
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
	
//	@RequestMapping("/data-pendaftar/update/{no_id}")
//	public String updateData(Model model, @PathVariable(value = "no_id") String no_id) {
//		List<LPTerdahuluModel> allLPT = lptDAO.selectAllLPT();
//		List<JalurMasukModel> jalurUndangan = jalurMasukDAO.selectAllJalurUndangan();
//		model.addAttribute("jalurUndangan", jalurUndangan);
//		model.addAttribute("allLPT", allLPT);
//		PendaftarModel pendaftar = pendaftarDAO.selectPendaftar(no_id);
//		if (pendaftar != null) {
//			model.addAttribute("pendaftar", pendaftar);
//			return "edit-siswa";
//		} else {
//			model.addAttribute("no_id", no_id);
//			return "error-update";
//		}
//	}
	
	@RequestMapping("/lihat-hasil")
	public String lihatHasil(Model model, @RequestParam(value = "no_daftar", required = false) int no_daftar,
			@RequestParam(value = "id_jalur", required = false) int id_jalur) {

		JalurMasukModel jalur = jalurMasukDAO.selectJalurMasuk(id_jalur);
		PenyeleksianModel penyeleksian = penyeleksianDAO.selectPenyeleksian2(no_daftar);
		PendaftarModel pendaftar = pendaftarDAO.selectNama(no_daftar);

		if (pendaftar != null) {
			if (penyeleksian.getStatus() == 1 & penyeleksian.getId_jalur() == jalur.getId_jalur()) {
				CalonMahasiswaModel calon = calonMahasiswaDAO.selectCalon(no_daftar);
				ProdiTersediaModel prodi = prodiTersediaDAO.selectProdi(calon.getId_prodi());
				String nama_prodi = prodi.getNama_prodi();
				int id_fakultas = prodi.getId_fakultas();
				FakultasModel fakultas = fakultasDAO.selectFakultas(id_fakultas);
				String nama_fakultas = fakultas.getFakultas();
				model.addAttribute("calon", calon);
				model.addAttribute("nama_prodi", nama_prodi);
				model.addAttribute("nama_fakultas", nama_fakultas);
					
			}
			
			model.addAttribute("jalur", jalur);
			model.addAttribute("penyeleksian", penyeleksian);
			model.addAttribute("pendaftar", pendaftar);
			
			return "hasil-seleksi";
			
		} else {
			return "hasil-seleksi-not-found";
		}
	}
}
