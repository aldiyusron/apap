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

import mosing.model.PendaftarModel;
import mosing.service.PendaftarService;

@Controller
public class PendaftarController {

	@Autowired
	PendaftarService pendaftarDAO;

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
		List<PendaftarModel> allSiswa = pendaftarDAO.selectAllSiswa();
		model.addAttribute("allSiswa", allSiswa);

		return "list-siswa-ppkb";
	}
	
	@RequestMapping("/data-siswa/submit")
	public String dataSubmit(@RequestParam(value = "no_id", required = false) String no_id,
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
		PendaftarModel pendaftar = new PendaftarModel(5, no_id, nama_id, nama_ijazah, null, null, null, null,
				null, null, jenis_id, null, null, null, null, jk,
				nama_lembaga, jurusan, 0);

		pendaftarDAO.addPendaftar(pendaftar);
		// return "success-datadiri";
		return "success-daftarseleksi";
	}
}
