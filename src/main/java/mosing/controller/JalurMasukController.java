package mosing.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import mosing.model.JalurMasukModel;
import mosing.service.JalurMasukService;

public class JalurMasukController {
	@Autowired
	JalurMasukService jalurMasukDAO;
	
	@RequestMapping("/daftarjalurmasuk/delete/{id_jalur}")
	public String deletejalurmasuk(Model model, @PathVariable(value = "id_jalur")String id_jalur) {
		JalurMasukModel jalurmasuk=jalurMasukDAO.selectJalurMasuk(id_jalur);
		//if (jalurmasuk != null || jalurmasuk.flag)
		return "notifikasidelete";
	}
	
	
}
