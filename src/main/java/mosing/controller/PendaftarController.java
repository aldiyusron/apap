package mosing.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import mosing.model.DaftarPilihanModel;
import mosing.model.JalurMasukModel;
import mosing.model.KotaModel;
import mosing.model.LPTerdahuluModel;
import mosing.model.PendaftarModel;
import mosing.model.PenyeleksianModel;
import mosing.model.ProdiTersediaModel;
import mosing.model.ProvinsiModel;
import mosing.model.UserAdmisiModel;

import mosing.service.JalurMasukService;
import mosing.service.KotaService;
import mosing.service.LPTerdahuluService;
import mosing.service.PendaftarService;
import mosing.service.PenyeleksianService;
import mosing.service.ProdiTersediaService;
import mosing.service.ProvinsiService;
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
	UserAdmisiService userDAO;

	@Autowired
	ProdiTersediaService prodiDAO;

	@Autowired
	JalurMasukService jalurmasukDAO;

	@Autowired
	ProvinsiService provinsiDAO;

	@Autowired
	KotaService kotaDAO;

	@RequestMapping("/pendaftar/{username}")
	public String add(Model model, @PathVariable(value = "username") String username) {
		PendaftarModel pendaftar = pendaftarDAO.selectPendaftar2(username);

		if (pendaftar != null) {
			PenyeleksianModel penyeleksian = penyeleksianDAO.selectPenyeleksian2(pendaftar.getNo_daftar());
			if (penyeleksian != null) {
				return "sudahdaftarseleksi";
			}
		}

		List<JalurMasukModel> jalurMasuk = jalurmasukDAO.selectAllJalurTulis();
		List<ProvinsiModel> allProvinsi = provinsiDAO.selectAllProvinsi();
		List<KotaModel> allKota = kotaDAO.selectKotaIndo();
		model.addAttribute("username", username);
		model.addAttribute("jalurMasuk", jalurMasuk);
		model.addAttribute("allProvinsi", allProvinsi);
		model.addAttribute("allKota", allKota);
		return "form-registrasi2";
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
		PendaftarModel pendaftar = new PendaftarModel(id_user, no_id, nama_id, nama_ijazah, null,
				no_hp, no_telp, nama_negara, kewarganegaraan, alamat_tetap, jenis_id, alamat_sekarang, tanggal_lahir,
				nama_provinsi, nama_kota, jk, 0, nama_lembaga, jurusan);

		pendaftarDAO.addPendaftar(pendaftar);
		PendaftarModel pendaftarSeleksi = pendaftarDAO.selectPendaftar2(username);
		Byte status = Byte.parseByte("0");
		int no_daftar = pendaftarSeleksi.getNo_daftar();
		PenyeleksianModel penyeleksian = new PenyeleksianModel(no_daftar, status, id_jalur, null);
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
				null, jenis_id, null, null, null, null, jk, 0, nama_lembaga, jurusan);

		pendaftarDAO.addPendaftar(pendaftar);
		PendaftarModel pendaftar2 = pendaftarDAO.selectPendaftar(no_id);
		// return "success-datadiri";
		byte status = 0;
		PenyeleksianModel penyeleksian = new PenyeleksianModel(pendaftar2.getNo_daftar(), status, jalur_undangan, null);
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
	public String dataUpdateSubmit(Model model, @RequestParam(value = "no_id", required = false) String no_id,
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
				null, jenis_id, null, null, null, null, jk, 0, nama_lembaga, jurusan);

		pendaftarDAO.updateDataPendaftar(pendaftar);
		// PendaftarModel pendaftar2 = pendaftarDAO.selectPendaftar(no_id);
		// return "success-datadiri";
		// byte status = 0;
		// PenyeleksianModel penyeleksian = new
		// PenyeleksianModel(pendaftar2.getNo_daftar(), status, jalur_undangan,
		// null);
		// penyeleksianDAO.addPenyeleksian(penyeleksian);
		// model.addAttribute("pendaftar2", pendaftar2);
		// if (pendaftar2.getJurusan().equalsIgnoreCase("IPA"))
		// return "form-nilai-ipa";
		// else
		// return "form-nilai-ips";
		return "success-update-data";
	}
}
