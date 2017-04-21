package mosing.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import mosing.model.PendaftarModel;
import mosing.model.JalurMasukModel;
import mosing.service.JalurMasukService;
import mosing.service.PendaftarService;
import mosing.service.UserAdmisiService;

@Controller
public class JalurMasukController {
	@Autowired
	JalurMasukService JalurMasukDAO;
	
	@RequestMapping("/jalur-masuk")
	public String lihatDaftarJalurMasuk(Model model) {
		List<JalurMasukModel> allJalur = JalurMasukDAO.selectAllJalurMasuk();
		model.addAttribute("allJalur", allJalur);

		return "view-alljalur"; //belum bener
}
	
	@RequestMapping("/jalur-masuk/add")
	public String tambahJalurMasuk() {
		return "form-addjalur"; //masih belum bener pagenya
	}
	
	@RequestMapping("/jalur-masuk/add/submit")
	public String jalurSubmit(@RequestParam(value = "nama", required = false) String nama,
			@RequestParam(value = "tanggal_buka", required = false) String tanggal_buka,
			@RequestParam(value = "tanggal_tutup", required = false) String tanggal_tutup,
			@RequestParam(value = "status", required = false) String status,
			@RequestParam(value = "nama_jenjang", required = false) String nama_jenjang,
			@RequestParam(value = "nama_program", required = false) String nama_program,
			@RequestParam(value = "persyaratan", required = false) String persyaratan) throws ParseException {

		if (status.equalsIgnoreCase("Buka"))
			status = "1";
		else
			status = "0";
		byte stat = Byte.parseByte(status);
		DateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
		DateFormat format2 = new SimpleDateFormat("dd/MM/yyyy");
		Date tgl_buka = format1.parse(tanggal_buka);
		Date tgl_tutup = format2.parse(tanggal_tutup);

		JalurMasukModel jalur_masuk = new JalurMasukModel(0, nama, tgl_buka, tgl_tutup, stat, nama_jenjang, nama_program, persyaratan, 1);

		JalurMasukDAO.addJalurMasuk(jalur_masuk);
		return "success-addjalur"; //belum bener
	}
	
	@GetMapping("/jalur-masuk/update/{id_jalur}")
	public String updateJalurMasuk(Model model, @PathVariable(value = "id_jalur") int id_jalur) {
		JalurMasukModel jalur = JalurMasukDAO.selectJalurMasuk(id_jalur);
		if (jalur != null) {
			model.addAttribute("jalur", jalur);
			return "update-lokasi"; //belum bener
		} else {
			model.addAttribute("id_jalur", id_jalur);
			return "error"; //belum bener
		}
	}

	@PostMapping("/jalur-masuk/update")
	public String updateJalurMasukSubmit(@ModelAttribute JalurMasukModel jalur) {
		JalurMasukDAO.updateJalurMasuk(jalur);
		return "success-update-lokasi"; //belum bener
}
}
