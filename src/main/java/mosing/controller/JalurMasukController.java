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
	
	@RequestMapping("/jalurmasuk/{id_jalur}")
	public String add(Model model, @PathVariable(value = "id_jalur") int id_jalur) {
		JalurMasukModel jalur_masuk = JalurMasukDAO.selectJalurMasuk(id_jalur);
		if (jalur_masuk != null) {
			return "success-registration"; //masih belum bener pagenya
		}
		model.addAttribute("id_jalur", id_jalur);
		return "form-registrasi2"; //masih belum bener pagenya
	}	
}
