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
	
//	@RequestMapping("/nilai-pendaftar/{no_id}")
//	public String add(Model model, @PathVariable(value = "no_id") String no_id) {
//		PendaftarModel pendaftar = pendaftarDAO.selectPendaftar(no_id);
//		if (pendaftar.getJurusan().equals("IPA"))
//			return "form-nilai-ipa";
//		else
//			return "form-nilai-ips";
//	}

	
}
