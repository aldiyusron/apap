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
import mosing.model.ProdiModel;
import mosing.model.JalurMasukModel;
import mosing.service.JalurMasukService;
import mosing.service.PendaftarService;
import mosing.service.ProdiService;
import mosing.service.UserAdmisiService;

@Controller
public class JalurMasukController {
	@Autowired
	JalurMasukService JalurMasukDAO;
	ProdiService ProdiDAO;

	@RequestMapping("/jalur-masuk")
	public String lihatDaftarJalurMasuk(Model model) {
		List<JalurMasukModel> allJalur = JalurMasukDAO.selectAllJalurMasuk();
		model.addAttribute("allJalur", allJalur);

		return "view-alljalur";
	}

	@RequestMapping("/jalur-masuk/view/{id_jalur}")
	public String lihatJalurMasuk(Model model, @PathVariable(value = "id_jalur") int id_jalur) {
		JalurMasukModel jalur_masuk = JalurMasukDAO.selectJalurMasuk(id_jalur);

		if (jalur_masuk != null) {
			model.addAttribute("jalur_masuk", jalur_masuk);
//			List<ProdiModel> allProdi = ProdiDAO.selectAllProdi(id_jalur);
//			model.addAttribute("allProdi", allProdi);
			return "view-jalurmasuk";
		} else {
			model.addAttribute("id_jalur", id_jalur);
			return "viewnotfound-jalurmasuk";
		}
	}

	@RequestMapping("/jalur-masuk/add")
	public String add() {
		return "form-addjalur"; // masih belum bener pagenya
	}

	@RequestMapping("/jalur-masuk/add/submit")
	public String addSubmit(@RequestParam(value = "nama", required = false) String nama,
			@RequestParam(value = "tanggal_buka", required = false) String tanggal_buka,
			@RequestParam(value = "tanggal_tutup", required = false) String tanggal_tutup,
			@RequestParam(value = "status", required = false) String status,
			@RequestParam(value = "nama_jenjang", required = false) String nama_jenjang,
			@RequestParam(value = "nama_program", required = false) String nama_program,
			@RequestParam(value = "persyaratan", required = false) String persyaratan) throws ParseException {

		if (status.equalsIgnoreCase("Aktif"))
			status = "1";
		else
			status = "0";
		byte stat = Byte.parseByte(status);
		DateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
		DateFormat format2 = new SimpleDateFormat("dd/MM/yyyy");
		Date tgl_buka = format1.parse(tanggal_buka);
		Date tgl_tutup = format2.parse(tanggal_tutup);

		JalurMasukModel jalur_masuk = new JalurMasukModel(0, nama, tgl_buka, tgl_tutup, stat, nama_jenjang,
				nama_program, persyaratan, 1, null);

		JalurMasukDAO.addJalurMasuk(jalur_masuk);
		return "success-addjalur"; // belum bener
	}

	@RequestMapping("/jalur-masuk/update/{id_jalur}")
	public String update(Model model, @PathVariable(value = "id_jalur") int id_jalur) {
		JalurMasukModel jalur = JalurMasukDAO.selectJalurMasuk(id_jalur);
		if (jalur != null) {
			model.addAttribute("jalur", jalur);
			return "form-updatejalur"; // belum bener
		} else {
			model.addAttribute("id_jalur", id_jalur);
			return "error-updatejalur"; // belum bener
		}
	}

	@RequestMapping(value = "/jalur-masuk/update/submit", method = RequestMethod.POST)
    public String updateSubmit(@RequestParam(value = "id_jalur", required = false) int id_jalur, @RequestParam(value = "nama", required = false) String nama,
			@RequestParam(value = "tanggal_buka", required = false) String tanggal_buka,
			@RequestParam(value = "tanggal_tutup", required = false) String tanggal_tutup,
			@RequestParam(value = "status", required = false) String status,
			@RequestParam(value = "nama_jenjang", required = false) String nama_jenjang,
			@RequestParam(value = "nama_program", required = false) String nama_program,
			@RequestParam(value = "persyaratan", required = false) String persyaratan) throws ParseException {

		if (status.equalsIgnoreCase("Aktif"))
			status = "1";
		else
			status = "0";
		byte stat = Byte.parseByte(status);
		DateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
		DateFormat format2 = new SimpleDateFormat("dd/MM/yyyy");
		Date tgl_buka = format1.parse(tanggal_buka);
		Date tgl_tutup = format2.parse(tanggal_tutup);
		
		JalurMasukModel jalur = JalurMasukDAO.selectJalurMasuk(id_jalur);

		JalurMasukModel jalur_masuk = new JalurMasukModel(id_jalur, nama, tgl_buka, tgl_tutup, stat, nama_jenjang, nama_program, persyaratan, 1, null);

		JalurMasukDAO.updateJalurMasuk(jalur_masuk);
		return "success-updatejalur"; //belum bener
	}
}
