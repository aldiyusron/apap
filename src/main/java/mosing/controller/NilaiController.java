package mosing.controller;

import java.text.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import mosing.model.NilaiModel;
import mosing.model.PendaftarModel;
import mosing.service.NilaiService;
import mosing.service.PendaftarService;

@Controller
public class NilaiController {

	@Autowired
	NilaiService nilaiDAO;
	
	@Autowired
	PendaftarService pendaftarDAO;
	
	@RequestMapping("/nilai-pendaftar/{no_id}")
	public String addNilai(Model model, @PathVariable(value="no_id") String no_id) {
		PendaftarModel pendaftar = pendaftarDAO.selectPendaftar(no_id);
		if (pendaftar.getJurusan() == "IPA")
		return "form-nilai-ipa";
		else
			return "form-nilai-ips";
	}
	
	@RequestMapping("/nilai-pendaftar/submit")
	public String addNilaiSubmit(@RequestParam(value="nama_id", required=false) String nama_id,
			@RequestParam(value="nama_ijazah", required=false) String nama_ijazah,
			@RequestParam(value="nisn", required=false) int nisn,
			@RequestParam(value="nama_lembaga", required=false) String nama_lembaga,
			@RequestParam(value="jurusan", required=false) String jurusan) throws ParseException {
		PendaftarModel pendaftar = new PendaftarModel(null, nama_id, nama_ijazah, nama_lembaga, jurusan);

		pendaftarDAO.addPendaftar2(pendaftar);
		return "";
	}
}
