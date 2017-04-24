package mosing.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import mosing.model.JalurMasukModel;
import mosing.service.JalurMasukService;

@Controller
public class JalurMasukController {
	
	@Autowired
	JalurMasukService jalurMasukDAO;
	
	@RequestMapping("/jalur-masuk")
	 public String lihatDaftarJalurMasuk(Model model) {
	 List<JalurMasukModel> allJalur = jalurMasukDAO.selectAllJalurMasuk();
	 		model.addAttribute("allJalur", allJalur);
	 
	 		return "view-alljalur"; //belum bener
	 }
//	@RequestMapping(value = "/detail-ujian/delete/{id_lokasi}", method=RequestMethod.GET)
//	public String hapusLokasi(Model model, @PathVariable(value="id_lokasi") int id_lokasi){
//		LokasiModel lokasi = lokasiDAO.selectLokasi(id_lokasi);
//		model.addAttribute("lokasi", lokasi);
//		
//		return "delete-lokasi";
//	}
//	
//	@RequestMapping(value="/detail-ujian/delete/submit/{id_lokasi}")
//	public String hapusLokasiSubmit(Model model, @PathVariable(value="id_lokasi") int id_lokasi){
//		LokasiModel lokasi = lokasiDAO.selectLokasi(id_lokasi);
//		model.addAttribute("lokasi", lokasi);
//		lokasiDAO.deleteLokasiUjian(lokasi);
//		
//		return "success-delete-lokasi";
//	}	
	@RequestMapping(value = "/jalur-masuk/delete/{id_jalur}", method=RequestMethod.GET)
	public String deletejalurmasuk(Model model, @PathVariable(value = "id_jalur")int id_jalur) {
		JalurMasukModel jalurmasuk=jalurMasukDAO.selectJalurMasuk(id_jalur);
		model.addAttribute("jalurmasuk", jalurmasuk);
		
		return "konfirmasi-deletejalur";
		
	}
	
	@RequestMapping(value="/jalur-masuk/delete/submit/{id_jalur}")
	public String deletejalurmasukSubmit(Model model, @PathVariable(value="id_jalur")int id_jalur) {
		JalurMasukModel jalurmasuk=jalurMasukDAO.selectJalurMasuk(id_jalur);
		model.addAttribute("jalurmasuk", jalurmasuk);
		jalurMasukDAO.deleteJalurMasuk(jalurmasuk);
	
		return "success-hapusjalur";
	}
	
}
