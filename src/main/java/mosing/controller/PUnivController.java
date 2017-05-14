package mosing.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import mosing.model.FakultasModel;
import mosing.model.PendaftarModel;
import mosing.model.PenyeleksianModel;
import mosing.service.FakultasService;
import mosing.service.PendaftarService;
import mosing.service.PenyeleksianService;

public class PUnivController {
	@Autowired
	PenyeleksianService penyeleksianDAO;
	
	@Autowired
	FakultasService fakultasDAO;
	
	//nampilin list fakultas
	@RequestMapping("/seleksi/ppkb")
	public String ppkb(Model model){
		List<FakultasModel> fakultas = fakultasDAO.selectAllFakultas();
		model.addAttribute("fakultas", fakultas);
		return "listFakultas";
	}
	
	//nampilin list prodi
	@RequestMapping("/seleksi/ppkb/{id_fakultas}")
	public String listProdi(Model model, @PathVariable(value = "id_fakultas") int id_fakultas){
		FakultasModel fakultas = fakultasDAO.selectFakultasDanProdi(id_fakultas);
		model.addAttribute("fakultas", fakultas);
		return "";
	}
	
	//nampilin list pendaftar ppkb di prodi dan fakultas tertentu
	@RequestMapping("/seleksi/ppkb/{id_fakultas}/{id_prodi}")
	public String listPendaftar(){
		return "";
	}
	
	
//	@RequestMapping("/list")
//	public String add(Model model){
//		List<PenyeleksianModel> seleksipendaftar = penyeleksianDAO.selectAllPenyeleksian();
//		return "daftarseleksipendaftar";
//		
//		
//		
//	}
}
