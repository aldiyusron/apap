package mosing.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import mosing.model.NilaiModel;
import mosing.service.NilaiService;
import mosing.service.PendaftarService;

@Controller
public class NilaiController {

	@Autowired
	NilaiService nilaiDAO;

	@Autowired
	PendaftarService pendaftarDAO;

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
			@RequestParam(value = "kkm_math", required = false) int kkm_math,
			@RequestParam(value = "kkm_indo", required = false) int kkm_indo,
			@RequestParam(value = "kkm_eng", required = false) int kkm_eng,
			@RequestParam(value = "kkm_geo", required = false) int kkm_geo,
			@RequestParam(value = "kkm_eko", required = false) int kkm_eko,
			@RequestParam(value = "kkm_his", required = false) int kkm_his,
			@RequestParam(value = "math1", required = false) int math1,
			@RequestParam(value = "math2", required = false) int math2,
			@RequestParam(value = "math3", required = false) int math3,
			@RequestParam(value = "math4", required = false) int math4,
			@RequestParam(value = "math5", required = false) int math5,
			@RequestParam(value = "indo1", required = false) int indo1,
			@RequestParam(value = "indo2", required = false) int indo2,
			@RequestParam(value = "indo3", required = false) int indo3,
			@RequestParam(value = "indo4", required = false) int indo4,
			@RequestParam(value = "indo5", required = false) int indo5,
			@RequestParam(value = "eng1", required = false) int eng1,
			@RequestParam(value = "eng2", required = false) int eng2,
			@RequestParam(value = "eng3", required = false) int eng3,
			@RequestParam(value = "eng4", required = false) int eng4,
			@RequestParam(value = "eng5", required = false) int eng5,
			@RequestParam(value = "geo1", required = false) int geo1,
			@RequestParam(value = "geo2", required = false) int geo2,
			@RequestParam(value = "geo3", required = false) int geo3,
			@RequestParam(value = "geo4", required = false) int geo4,
			@RequestParam(value = "geo5", required = false) int geo5,
			@RequestParam(value = "eko1", required = false) int eko1,
			@RequestParam(value = "eko2", required = false) int eko2,
			@RequestParam(value = "eko3", required = false) int eko3,
			@RequestParam(value = "eko4", required = false) int eko4,
			@RequestParam(value = "eko5", required = false) int eko5,
			@RequestParam(value = "his1", required = false) int his1,
			@RequestParam(value = "his2", required = false) int his2,
			@RequestParam(value = "his3", required = false) int his3,
			@RequestParam(value = "his4", required = false) int his4,
			@RequestParam(value = "his5", required = false) int his5) throws ParseException {

		List<String> daftar = new ArrayList<String>();
		daftar.add(math1 + "-" + his1 + "-" + geo1 + "-" + eko1 + "-" + indo1 + "-" + eng1);
		daftar.add(math2 + "-" + his2 + "-" + geo2 + "-" + eko2 + "-" + indo2 + "-" + eng2);
		daftar.add(math3 + "-" + his3 + "-" + geo3 + "-" + eko3 + "-" + indo3 + "-" + eng3);
		daftar.add(math4 + "-" + his4 + "-" + geo4 + "-" + eko4 + "-" + indo4 + "-" + eng4);
		daftar.add(math5 + "-" + his5 + "-" + geo5 + "-" + eko5 + "-" + indo5 + "-" + eng5);
		System.out.print(jurusan);
		for (int i = 0; i < daftar.size(); i++) {
			String daftarnilai = daftar.get(i);
			String[] parts = daftarnilai.split("-");
			NilaiModel nilai = new NilaiModel(no_daftar, kkm_math, 0, 0, 0, kkm_his, kkm_geo, kkm_eko, kkm_indo,
					kkm_eng, Integer.parseInt(parts[0]), 0, 0, 0, Integer.parseInt(parts[1]),
					Integer.parseInt(parts[2]), Integer.parseInt(parts[3]), Integer.parseInt(parts[4]),
					Integer.parseInt(parts[5]), i + 1);

			nilaiDAO.addNilai(nilai);
		}
		return "success-insert-nilai";
	}

	@RequestMapping("/nilai-ipa/submit")
	public String submitNilaiIPA(@RequestParam(value = "jurusan", required = false) String jurusan,
			@RequestParam(value = "no_daftar", required = false) int no_daftar,
			@RequestParam(value = "kkm_math", required = false) int kkm_math,
			@RequestParam(value = "kkm_chem", required = false) int kkm_chem,
			@RequestParam(value = "kkm_phy", required = false) int kkm_phy,
			@RequestParam(value = "kkm_bio", required = false) int kkm_bio,
			@RequestParam(value = "kkm_indo", required = false) int kkm_indo,
			@RequestParam(value = "kkm_eng", required = false) int kkm_eng,
			@RequestParam(value = "math1", required = false) int math1,
			@RequestParam(value = "math2", required = false) int math2,
			@RequestParam(value = "math3", required = false) int math3,
			@RequestParam(value = "math4", required = false) int math4,
			@RequestParam(value = "math5", required = false) int math5,
			@RequestParam(value = "chem1", required = false) int chem1,
			@RequestParam(value = "chem2", required = false) int chem2,
			@RequestParam(value = "chem3", required = false) int chem3,
			@RequestParam(value = "chem4", required = false) int chem4,
			@RequestParam(value = "chem5", required = false) int chem5,
			@RequestParam(value = "phy1", required = false) int phy1,
			@RequestParam(value = "phy2", required = false) int phy2,
			@RequestParam(value = "phy3", required = false) int phy3,
			@RequestParam(value = "phy4", required = false) int phy4,
			@RequestParam(value = "phy5", required = false) int phy5,
			@RequestParam(value = "bio1", required = false) int bio1,
			@RequestParam(value = "bio2", required = false) int bio2,
			@RequestParam(value = "bio3", required = false) int bio3,
			@RequestParam(value = "bio4", required = false) int bio4,
			@RequestParam(value = "bio5", required = false) int bio5,
			@RequestParam(value = "indo1", required = false) int indo1,
			@RequestParam(value = "indo2", required = false) int indo2,
			@RequestParam(value = "indo3", required = false) int indo3,
			@RequestParam(value = "indo4", required = false) int indo4,
			@RequestParam(value = "indo5", required = false) int indo5,
			@RequestParam(value = "eng1", required = false) int eng1,
			@RequestParam(value = "eng2", required = false) int eng2,
			@RequestParam(value = "eng3", required = false) int eng3,
			@RequestParam(value = "eng4", required = false) int eng4,
			@RequestParam(value = "eng5", required = false) int eng5) throws ParseException {

		List<String> daftar = new ArrayList<String>();
		daftar.add(math1 + "-" + chem1 + "-" + phy1 + "-" + bio1 + "-" + indo1 + "-" + eng1);
		daftar.add(math2 + "-" + chem2 + "-" + phy2 + "-" + bio2 + "-" + indo2 + "-" + eng2);
		daftar.add(math3 + "-" + chem3 + "-" + phy3 + "-" + bio3 + "-" + indo3 + "-" + eng3);
		daftar.add(math4 + "-" + chem4 + "-" + phy4 + "-" + bio4 + "-" + indo4 + "-" + eng4);
		daftar.add(math5 + "-" + chem5 + "-" + phy5 + "-" + bio5 + "-" + indo5 + "-" + eng5);

		for (int i = 0; i < daftar.size(); i++) {
			String daftarnilai = daftar.get(i);
			String[] parts = daftarnilai.split("-");
			NilaiModel nilai = new NilaiModel(no_daftar, kkm_math, kkm_chem, kkm_phy, kkm_bio, 0, 0, 0, kkm_indo,
					kkm_eng, Integer.parseInt(parts[0]), Integer.parseInt(parts[1]), Integer.parseInt(parts[2]),
					Integer.parseInt(parts[3]), 0, 0, 0, Integer.parseInt(parts[4]), Integer.parseInt(parts[5]), i + 1);

			nilaiDAO.addNilai(nilai);
		}
		return "success-insert-nilai";
	}
}
