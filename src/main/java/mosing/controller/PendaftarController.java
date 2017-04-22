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
import org.springframework.web.bind.annotation.RequestParam;

import mosing.model.JalurMasukModel;
import mosing.model.PendaftarModel;
import mosing.model.PenyeleksianModel;
import mosing.model.ProdiTersediaModel;
import mosing.model.UserAdmisiModel;
import mosing.service.JalurMasukService;
import mosing.service.PendaftarService;
import mosing.service.ProdiService;
import mosing.service.UserAdmisiService;

@Controller
public class PendaftarController {

	@Autowired
	PendaftarService pendaftarDAO;

	@Autowired
	UserAdmisiService userDAO;

	@Autowired
	ProdiService prodiDAO;

	@Autowired
	JalurMasukService jalurmasukDAO;

	@RequestMapping("/pendaftar/{username}")
	public String add(Model model, @PathVariable(value = "username") String username) {
		PendaftarModel pendaftar = pendaftarDAO.selectPendaftar(username);
		if(pendaftar != null)
		{
			PenyeleksianModel penyeleksian = pendaftarDAO.selectPenyeleksian(pendaftar.getNo_daftar());
			if(penyeleksian != null)
			{
				return "sudahdaftarseleksi";
			}
		}
			
		List<JalurMasukModel> jalurMasuk = jalurmasukDAO.selectAllJalurMasuk();
		model.addAttribute("username", username);
		model.addAttribute("jalurMasuk", jalurMasuk);
		return "form-registrasi2";
	}

	@RequestMapping("/pendaftar/rencanastudi")
	public String profileSubmit(Model model, @RequestParam(value = "username", required = false) String username,
			@RequestParam(value = "jenis_id", required = false) String jenis_id,
			@RequestParam(value = "no_id", required = false) String no_id,
			@RequestParam(value = "nama_id", required = false) String nama_id,
			@RequestParam(value = "nama_ijazah", required = false) String nama_ijazah,
			// @RequestParam(value = "foto", required = false) String foto,
			@RequestParam(value = "no_hp", required = false) String no_hp,
			@RequestParam(value = "no_telp", required = false) String no_telp,
			@RequestParam(value = "negara", required = false) String negara,
			@RequestParam(value = "kewarganegaraan", required = false) String kewarganegaraan,
			@RequestParam(value = "alamat_tetap", required = false) String alamat_tetap,
			@RequestParam(value = "alamat_sekarang", required = false) String alamat_sekarang,
			@RequestParam(value = "tgl_lahir", required = false) String tgl_lahir,
			@RequestParam(value = "provinsi", required = false) String provinsi,
			@RequestParam(value = "kota", required = false) String kota,
			@RequestParam(value = "jenis_kelamin", required = false) String jenis_kelamin,
			@RequestParam(value = "no_daftar", required = false) String no_daftar,
			@RequestParam(value = "jurusan", required = false) String jurusan,
			@RequestParam(value = "id_jalur", required = false) String id_jalur) throws ParseException {

		if (jenis_kelamin.equalsIgnoreCase("Laki-laki"))
			jenis_kelamin = "1";
		else
			jenis_kelamin = "0";

		UserAdmisiModel user = userDAO.selectUser(username);
		byte jk = Byte.parseByte(jenis_kelamin);
		DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		Date tanggal_lahir = format.parse(tgl_lahir);

		PenyeleksianModel penyeleksian = new PenyeleksianModel(no_daftar, 0, id_jalur, null);
		PendaftarModel pendaftar = new PendaftarModel(user.getId_user(), no_id, nama_id, nama_ijazah, "www.xxx.com",
				no_hp, no_telp, negara, kewarganegaraan, alamat_tetap, jenis_id, alamat_sekarang, tanggal_lahir,
				provinsi, kota, jk, null, jurusan, null);

		pendaftarDAO.addPendaftar(pendaftar);

		List<ProdiTersediaModel> prodiTersedia = prodiDAO.selectAllProdi(id_jalur);
		model.addAttribute("prodiTersedia", prodiTersedia);
		return "formrencanastudi";
	}

	@RequestMapping("/pendaftar/rencanastudi/submit")
	public String rencanaStudiSubmit(@RequestParam(value = "jenjang", required = false) String jenjang,
			@RequestParam(value = "pilihan1", required = false) String pilihan1,
			@RequestParam(value = "pilihan2", required = false) String pilihan2,
			@RequestParam(value = "pilihan3", required = false) String pilihan3,
			@RequestParam(value = "pilihan4", required = false) String pilihan4,
			@RequestParam(value = "pilihan5", required = false) String pilihan5,
			@RequestParam(value = "pilihan6", required = false) String pilihan6) {
		return "hhh"; // blm selesai
	}
}
