package mosing.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import mosing.model.PendaftarModel;
import mosing.model.UserAdmisiModel;
import mosing.service.PendaftarService;
import mosing.service.UserAdmisiService;

@Controller
public class PendaftarController {

	@Autowired
	PendaftarService pendaftarDAO;
	UserAdmisiService userDAO;

//	@RequestMapping("/pendaftar/registrasi")
//	public String add() {
//		return "form-registrasi";
//	}

	@RequestMapping("/pendaftar/register/{username}")
	public String addSubmit(Model model, @PathVariable(value = "username") String username,
			@RequestParam(value = "jenis_id", required = false) String jenis_id,
			@RequestParam(value = "no_id", required = false) String no_id,
			@RequestParam(value = "nama_id", required = false) String nama_id,
			@RequestParam(value = "nama_ijazah", required = false) String nama_ijazah,
			@RequestParam(value = "foto", required = false) String foto,
			@RequestParam(value = "no_hp", required = false) String no_hp,
			@RequestParam(value = "no_telp", required = false) String no_telp,
			@RequestParam(value = "negara", required = false) String negara,
			@RequestParam(value = "kewarganegaraan", required = false) String kewarganegaraan,
			@RequestParam(value = "alamat_tetap", required = false) String alamat_tetap,
			@RequestParam(value = "alamat_sekarang", required = false) String alamat_sekarang,
			@RequestParam(value = "tgl_lahir", required = false) String tgl_lahir,
			@RequestParam(value = "provinsi", required = false) String provinsi,
			@RequestParam(value = "kota", required = false) String kota,
			@RequestParam(value = "jenis_kelamin", required = false) String jenis_kelamin) throws ParseException {

		byte jk = Byte.parseByte(jenis_kelamin);
		DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		Date tanggal_lahir = format.parse(tgl_lahir);
		UserAdmisiModel user = userDAO.selectUser(username);
		model.addAttribute("user", user);
		PendaftarModel pendaftar = new PendaftarModel(username, no_id, nama_id, nama_ijazah,
				foto, no_hp, no_telp, negara, kewarganegaraan, alamat_tetap, jenis_id, alamat_sekarang, tanggal_lahir,
				provinsi, kota, jk, "", "");
//		PendaftarModel pendaftar = new PendaftarModel(user, no_id, nama_id, nama_ijazah,
//				foto, no_hp, no_telp, negara, kewarganegaraan, alamat_tetap, jenis_id, alamat_sekarang, tanggal_lahir,
//				provinsi, kota, jk, "", "");
		pendaftarDAO.addPendaftar(pendaftar);
		return "success-registration";
	}
}
