package mosing.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import mosing.model.NilaiModel;

import mosing.service.JalurMasukService;
import mosing.service.LPTerdahuluService;
import mosing.service.NilaiService;
import mosing.service.PendaftarService;

@Controller
public class NilaiController {

	@Autowired
	NilaiService nilaiDAO;

	@Autowired
	PendaftarService pendaftarDAO;
	
	@Autowired
	LPTerdahuluService lptDAO;
	
	@Autowired
	JalurMasukService jalurMasukDAO;

	// @RequestMapping("/nilai-pendaftar/{no_id}")
	// public String add(Model model, @PathVariable(value = "no_id") String
	// no_id) {
	// PendaftarModel pendaftar = pendaftarDAO.selectPendaftar(no_id);
	// if (pendaftar.getJurusan().equals("IPA"))
	// return "form-nilai-ipa";
	// else
	// return "form-nilai-ips";
	// }

	@RequestMapping("/nilai-ips/submit")
	public String submitNilaiIPS(@RequestParam(value = "jurusan", required = false) String jurusan,
			@RequestParam(value = "no_daftar", required = false) int no_daftar,
			@RequestParam(value = "kkm_mtk", required = false) int kkm_mtk,
			@RequestParam(value = "kkm_bindo", required = false) int kkm_bindo,
			@RequestParam(value = "kkm_bing", required = false) int kkm_bing,
			@RequestParam(value = "kkm_geografi", required = false) int kkm_geo,
			@RequestParam(value = "kkm_ekonomi", required = false) int kkm_ekonomi,
			@RequestParam(value = "kkm_sejarah", required = false) int kkm_sejarah,
			@RequestParam(value = "mtk1", required = false) int mtk1,
			@RequestParam(value = "mtk2", required = false) int mtk2,
			@RequestParam(value = "mtk3", required = false) int mtk3,
			@RequestParam(value = "mtk4", required = false) int mtk4,
			@RequestParam(value = "mtk5", required = false) int mtk5,
			@RequestParam(value = "bindo1", required = false) int bindo1,
			@RequestParam(value = "bindo2", required = false) int bindo2,
			@RequestParam(value = "bindo3", required = false) int bindo3,
			@RequestParam(value = "bindo4", required = false) int bindo4,
			@RequestParam(value = "bindo5", required = false) int bindo5,
			@RequestParam(value = "bing1", required = false) int bing1,
			@RequestParam(value = "bing2", required = false) int bing2,
			@RequestParam(value = "bing3", required = false) int bing3,
			@RequestParam(value = "bing4", required = false) int bing4,
			@RequestParam(value = "bing5", required = false) int bing5,
			@RequestParam(value = "geografi1", required = false) int geo1,
			@RequestParam(value = "geografi2", required = false) int geo2,
			@RequestParam(value = "geografi3", required = false) int geo3,
			@RequestParam(value = "geografi4", required = false) int geo4,
			@RequestParam(value = "geografi5", required = false) int geo5,
			@RequestParam(value = "ekonomi1", required = false) int ekonomi1,
			@RequestParam(value = "ekonomi2", required = false) int ekonomi2,
			@RequestParam(value = "ekonomi3", required = false) int ekonomi3,
			@RequestParam(value = "ekonomi4", required = false) int ekonomi4,
			@RequestParam(value = "ekonomi5", required = false) int ekonomi5,
			@RequestParam(value = "sejarah1", required = false) int sejarah1,
			@RequestParam(value = "sejarah2", required = false) int sejarah2,
			@RequestParam(value = "sejarah3", required = false) int sejarah3,
			@RequestParam(value = "sejarah4", required = false) int sejarah4,
			@RequestParam(value = "sejarah5", required = false) int sejarah5) throws ParseException {

		List<String> daftar = new ArrayList<String>();
		daftar.add(mtk1 + "-" + sejarah1 + "-" + geo1 + "-" + ekonomi1 + "-" + bindo1 + "-" + bing1);
		daftar.add(mtk2 + "-" + sejarah2 + "-" + geo2 + "-" + ekonomi2 + "-" + bindo2 + "-" + bing2);
		daftar.add(mtk3 + "-" + sejarah3 + "-" + geo3 + "-" + ekonomi3 + "-" + bindo3 + "-" + bing3);
		daftar.add(mtk4 + "-" + sejarah4 + "-" + geo4 + "-" + ekonomi4 + "-" + bindo4 + "-" + bing4);
		daftar.add(mtk5 + "-" + sejarah5 + "-" + geo5 + "-" + ekonomi5 + "-" + bindo5 + "-" + bing5);
		System.out.print(jurusan);
		for (int i = 0; i < daftar.size(); i++) {
			String daftarnilai = daftar.get(i);
			String[] parts = daftarnilai.split("-");
			NilaiModel nilai = new NilaiModel(no_daftar, kkm_mtk, 0, 0, 0, kkm_sejarah, kkm_geo, kkm_ekonomi, kkm_bindo,
					kkm_bing, Integer.parseInt(parts[0]), 0, 0, 0, Integer.parseInt(parts[1]),
					Integer.parseInt(parts[2]), Integer.parseInt(parts[3]), Integer.parseInt(parts[4]),
					Integer.parseInt(parts[5]), i + 1);

			nilaiDAO.addNilai(nilai);
		}
		return "success-insert-nilai";
	}

	@RequestMapping("/nilai-ipa/submit")
	public String submitNilaiIPA(@RequestParam(value = "jurusan", required = false) String jurusan,
			@RequestParam(value = "no_daftar", required = false) int no_daftar,
			@RequestParam(value = "kkm_mtk", required = false) int kkm_mtk,
			@RequestParam(value = "kkm_kimia", required = false) int kkm_kimia,
			@RequestParam(value = "kkm_fisika", required = false) int kkm_fisika,
			@RequestParam(value = "kkm_biologi", required = false) int kkm_biologi,
			@RequestParam(value = "kkm_bindo", required = false) int kkm_bindo,
			@RequestParam(value = "kkm_bing", required = false) int kkm_bing,
			@RequestParam(value = "mtk1", required = false) int mtk1,
			@RequestParam(value = "mtk2", required = false) int mtk2,
			@RequestParam(value = "mtk3", required = false) int mtk3,
			@RequestParam(value = "mtk4", required = false) int mtk4,
			@RequestParam(value = "mtk5", required = false) int mtk5,
			@RequestParam(value = "kimia1", required = false) int kimia1,
			@RequestParam(value = "kimia2", required = false) int kimia2,
			@RequestParam(value = "kimia3", required = false) int kimia3,
			@RequestParam(value = "kimia4", required = false) int kimia4,
			@RequestParam(value = "kimia5", required = false) int kimia5,
			@RequestParam(value = "fisika1", required = false) int fisika1,
			@RequestParam(value = "fisika2", required = false) int fisika2,
			@RequestParam(value = "fisika3", required = false) int fisika3,
			@RequestParam(value = "fisika4", required = false) int fisika4,
			@RequestParam(value = "fisika5", required = false) int fisika5,
			@RequestParam(value = "biologi1", required = false) int biologi1,
			@RequestParam(value = "biologi2", required = false) int biologi2,
			@RequestParam(value = "biologi3", required = false) int biologi3,
			@RequestParam(value = "biologi4", required = false) int biologi4,
			@RequestParam(value = "biologi5", required = false) int biologi5,
			@RequestParam(value = "bindo1", required = false) int bindo1,
			@RequestParam(value = "bindo2", required = false) int bindo2,
			@RequestParam(value = "bindo3", required = false) int bindo3,
			@RequestParam(value = "bindo4", required = false) int bindo4,
			@RequestParam(value = "bindo5", required = false) int bindo5,
			@RequestParam(value = "bing1", required = false) int bing1,
			@RequestParam(value = "bing2", required = false) int bing2,
			@RequestParam(value = "bing3", required = false) int bing3,
			@RequestParam(value = "bing4", required = false) int bing4,
			@RequestParam(value = "bing5", required = false) int bing5) throws ParseException {

		List<String> daftar = new ArrayList<String>();
		daftar.add(mtk1 + "-" + kimia1 + "-" + fisika1 + "-" + biologi1 + "-" + bindo1 + "-" + bing1);
		daftar.add(mtk2 + "-" + kimia2 + "-" + fisika2 + "-" + biologi2 + "-" + bindo2 + "-" + bing2);
		daftar.add(mtk3 + "-" + kimia3 + "-" + fisika3 + "-" + biologi3 + "-" + bindo3 + "-" + bing3);
		daftar.add(mtk4 + "-" + kimia4 + "-" + fisika4 + "-" + biologi4 + "-" + bindo4 + "-" + bing4);
		daftar.add(mtk5 + "-" + kimia5 + "-" + fisika5 + "-" + biologi5 + "-" + bindo5 + "-" + bing5);

		for (int i = 0; i < daftar.size(); i++) {
			String daftarnilai = daftar.get(i);
			String[] parts = daftarnilai.split("-");
			NilaiModel nilai = new NilaiModel(no_daftar, kkm_mtk, kkm_kimia, kkm_fisika, kkm_biologi, 0, 0, 0,
					kkm_bindo, kkm_bing, Integer.parseInt(parts[0]), Integer.parseInt(parts[1]),
					Integer.parseInt(parts[2]), Integer.parseInt(parts[3]), 0, 0, 0, Integer.parseInt(parts[4]),
					Integer.parseInt(parts[5]), i + 1);

			nilaiDAO.addNilai(nilai);
		}
		return "success-insert-nilai";
	}
	
	@RequestMapping("/nilai-ips/update/{no_daftar}")
	public String updateNilaiIPS(Model model, @PathVariable(value = "no_daftar") int no_daftar) {
		List <NilaiModel> nilai = nilaiDAO.selectNilai(no_daftar);
		int kkm_mtk = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_mtk();
		int kkm_sejarah = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_sejarah();
		int kkm_geografi = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_geografi();
		int kkm_ekonomi = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_ekonomi();
		int kkm_bindo = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_bindo();
		int kkm_bing = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_bing();
		
			model.addAttribute("kkm_mtk", kkm_mtk);
			model.addAttribute("kkm_sejarah", kkm_sejarah);
			model.addAttribute("kkm_geografi", kkm_geografi);
			model.addAttribute("kkm_ekonomi", kkm_ekonomi);
			model.addAttribute("kkm_bindo", kkm_bindo);
			model.addAttribute("kkm_bing", kkm_bing);
			model.addAttribute("nilai", nilai);
			model.addAttribute("no_daftar", no_daftar);
			return "edit-nilai-ips";
		
	}

	@RequestMapping(value="/nilai-ips/update/submit")
	public String updateNilaiIPSSubmit(Model model, 
			@RequestParam(value = "no_daftar", required = false) int no_daftar,
			@RequestParam(value = "kkm_mtk", required = false) int kkm_mtk,
			@RequestParam(value = "kkm_bindo", required = false) int kkm_bindo,
			@RequestParam(value = "kkm_bing", required = false) int kkm_bing,
			@RequestParam(value = "kkm_geografi", required = false) int kkm_geografi,
			@RequestParam(value = "kkm_ekonomi", required = false) int kkm_ekonomi,
			@RequestParam(value = "kkm_sejarah", required = false) int kkm_sejarah,
			@RequestParam(value = "mtk1", required = false) int mtk1,
			@RequestParam(value = "mtk2", required = false) int mtk2,
			@RequestParam(value = "mtk3", required = false) int mtk3,
			@RequestParam(value = "mtk4", required = false) int mtk4,
			@RequestParam(value = "mtk5", required = false) int mtk5,
			@RequestParam(value = "bindo1", required = false) int bindo1,
			@RequestParam(value = "bindo2", required = false) int bindo2,
			@RequestParam(value = "bindo3", required = false) int bindo3,
			@RequestParam(value = "bindo4", required = false) int bindo4,
			@RequestParam(value = "bindo5", required = false) int bindo5,
			@RequestParam(value = "bing1", required = false) int bing1,
			@RequestParam(value = "bing2", required = false) int bing2,
			@RequestParam(value = "bing3", required = false) int bing3,
			@RequestParam(value = "bing4", required = false) int bing4,
			@RequestParam(value = "bing5", required = false) int bing5,
			@RequestParam(value = "geografi1", required = false) int geografi1,
			@RequestParam(value = "geografi2", required = false) int geografi2,
			@RequestParam(value = "geografi3", required = false) int geografi3,
			@RequestParam(value = "geografi4", required = false) int geografi4,
			@RequestParam(value = "geografi5", required = false) int geografi5,
			@RequestParam(value = "ekonomi1", required = false) int ekonomi1,
			@RequestParam(value = "ekonomi2", required = false) int ekonomi2,
			@RequestParam(value = "ekonomi3", required = false) int ekonomi3,
			@RequestParam(value = "ekonomi4", required = false) int ekonomi4,
			@RequestParam(value = "ekonomi5", required = false) int ekonomi5,
			@RequestParam(value = "sejarah1", required = false) int sejarah1,
			@RequestParam(value = "sejarah2", required = false) int sejarah2,
			@RequestParam(value = "sejarah3", required = false) int sejarah3,
			@RequestParam(value = "sejarah4", required = false) int sejarah4,
			@RequestParam(value = "sejarah5", required = false) int sejarah5) throws ParseException {

		List<String> daftar = new ArrayList<String>();
		daftar.add(mtk1 + "-" + sejarah1 + "-" + geografi1 + "-" + ekonomi1 + "-" + bindo1 + "-" + bing1);
		daftar.add(mtk2 + "-" + sejarah2 + "-" + geografi2 + "-" + ekonomi2 + "-" + bindo2 + "-" + bing2);
		daftar.add(mtk3 + "-" + sejarah3 + "-" + geografi3 + "-" + ekonomi3 + "-" + bindo3 + "-" + bing3);
		daftar.add(mtk4 + "-" + sejarah4 + "-" + geografi4 + "-" + ekonomi4 + "-" + bindo4 + "-" + bing4);
		daftar.add(mtk5 + "-" + sejarah5 + "-" + geografi5 + "-" + ekonomi5 + "-" + bindo5 + "-" + bing5);
		for (int i = 0; i < daftar.size(); i++) {
			String daftarnilai = daftar.get(i);
			String[] parts = daftarnilai.split("-");
			NilaiModel nilai = new NilaiModel(no_daftar, kkm_mtk, 0, 0, 0, kkm_sejarah, kkm_geografi, kkm_ekonomi, kkm_bindo,
					kkm_bing, Integer.parseInt(parts[0]), 0, 0, 0, Integer.parseInt(parts[1]),
					Integer.parseInt(parts[2]), Integer.parseInt(parts[3]), Integer.parseInt(parts[4]),
					Integer.parseInt(parts[5]), i + 1);

			nilaiDAO.updateNilai(nilai);
		}
		return "success-update-nilai";
	}
	
	@RequestMapping("/nilai-ipa/update/{no_daftar}")
	public String updateNilaiIPA(Model model, @PathVariable(value = "no_daftar") int no_daftar) {
		List <NilaiModel> nilai = nilaiDAO.selectNilai(no_daftar);
		int kkm_mtk = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_mtk();
		int kkm_kimia = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_kimia();
		int kkm_fisika = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_fisika();
		int kkm_biologi = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_biologi();
		int kkm_bindo = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_bindo();
		int kkm_bing = nilaiDAO.selectNilai(no_daftar).get(1).getKkm_bing();
		if(nilai != null) {
			model.addAttribute("kkm_mtk", kkm_mtk);
			model.addAttribute("kkm_kimia", kkm_kimia);
			model.addAttribute("kkm_fisika", kkm_fisika);
			model.addAttribute("kkm_biologi", kkm_biologi);
			model.addAttribute("kkm_bindo", kkm_bindo);
			model.addAttribute("kkm_bing", kkm_bing);
			model.addAttribute("nilai", nilai);
			model.addAttribute("no_daftar", no_daftar);
			return "edit-nilai-ipa";
		}
		else {
			model.addAttribute("no_daftar", no_daftar);
			return "error-update";
		}
	}
	
	@RequestMapping(value="/nilai-ipa/update/submit")
	public String updateNilaiIPASubmit(Model model, 
			@RequestParam(value = "no_daftar", required = false) int no_daftar,
			@RequestParam(value = "kkm_mtk", required = false) int kkm_mtk,
			@RequestParam(value = "kkm_bindo", required = false) int kkm_bindo,
			@RequestParam(value = "kkm_bing", required = false) int kkm_bing,
			@RequestParam(value = "kkm_kimia", required = false) int kkm_kimia,
			@RequestParam(value = "kkm_fisika", required = false) int kkm_fisika,
			@RequestParam(value = "kkm_biologi", required = false) int kkm_biologi,
			@RequestParam(value = "mtk1", required = false) int mtk1,
			@RequestParam(value = "mtk2", required = false) int mtk2,
			@RequestParam(value = "mtk3", required = false) int mtk3,
			@RequestParam(value = "mtk4", required = false) int mtk4,
			@RequestParam(value = "mtk5", required = false) int mtk5,
			@RequestParam(value = "bindo1", required = false) int bindo1,
			@RequestParam(value = "bindo2", required = false) int bindo2,
			@RequestParam(value = "bindo3", required = false) int bindo3,
			@RequestParam(value = "bindo4", required = false) int bindo4,
			@RequestParam(value = "bindo5", required = false) int bindo5,
			@RequestParam(value = "bing1", required = false) int bing1,
			@RequestParam(value = "bing2", required = false) int bing2,
			@RequestParam(value = "bing3", required = false) int bing3,
			@RequestParam(value = "bing4", required = false) int bing4,
			@RequestParam(value = "bing5", required = false) int bing5,
			@RequestParam(value = "kimia1", required = false) int kimia1,
			@RequestParam(value = "kimia2", required = false) int kimia2,
			@RequestParam(value = "kimia3", required = false) int kimia3,
			@RequestParam(value = "kimia4", required = false) int kimia4,
			@RequestParam(value = "kimia5", required = false) int kimia5,
			@RequestParam(value = "fisika1", required = false) int fisika1,
			@RequestParam(value = "fisika2", required = false) int fisika2,
			@RequestParam(value = "fisika3", required = false) int fisika3,
			@RequestParam(value = "fisika4", required = false) int fisika4,
			@RequestParam(value = "fisika5", required = false) int fisika5,
			@RequestParam(value = "biologi1", required = false) int biologi1,
			@RequestParam(value = "biologi2", required = false) int biologi2,
			@RequestParam(value = "biologi3", required = false) int biologi3,
			@RequestParam(value = "biologi4", required = false) int biologi4,
			@RequestParam(value = "biologi5", required = false) int biologi5) throws ParseException {

		List<String> daftar = new ArrayList<String>();
		daftar.add(mtk1 + "-" + kimia1 + "-" + fisika1 + "-" + biologi1 + "-" + bindo1 + "-" + bing1);
		daftar.add(mtk2 + "-" + kimia2 + "-" + fisika2 + "-" + biologi2 + "-" + bindo2 + "-" + bing2);
		daftar.add(mtk3 + "-" + kimia3 + "-" + fisika3 + "-" + biologi3 + "-" + bindo3 + "-" + bing3);
		daftar.add(mtk4 + "-" + kimia4 + "-" + fisika4 + "-" + biologi4 + "-" + bindo4 + "-" + bing4);
		daftar.add(mtk5 + "-" + kimia5 + "-" + fisika5 + "-" + biologi5 + "-" + bindo5 + "-" + bing5);
//		int rapor_satu = ((mtk1+kimia1+fisika1+biologi1+bindo1+bing1)/6);
//		int rapor_dua = (mtk2+kimia2+fisika2+biologi2+bindo2+bing2)/6;
//		int rapor_tiga = (mtk3+kimia3+fisika3+biologi3+bindo3+bing3)/6;
//		int rapor_empat = (mtk4+kimia4+fisika4+biologi4+bindo4+bing4)/6;
//		int rapor_lima = (mtk5+kimia5+fisika5+biologi5+bindo5+bing5)/6;
//		System.out.println(rapor_satu);
		for (int i = 0; i < daftar.size(); i++) {
			String daftarnilai = daftar.get(i);
			String[] parts = daftarnilai.split("-");
			NilaiModel nilai = new NilaiModel(no_daftar, kkm_mtk, kkm_kimia, kkm_fisika, kkm_biologi, 0, 0, 0,
					kkm_bindo, kkm_bing, Integer.parseInt(parts[0]), Integer.parseInt(parts[1]),
					Integer.parseInt(parts[2]), Integer.parseInt(parts[3]), 0, 0, 0, Integer.parseInt(parts[4]),
					Integer.parseInt(parts[5]), i + 1);

			nilaiDAO.updateNilai(nilai);
		}
		return "success-update-nilai";
	}
}
