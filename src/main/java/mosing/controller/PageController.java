package mosing.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import mosing.model.JalurMasukModel;
import mosing.model.KotaModel;
import mosing.model.PendaftarModel;
import mosing.model.PenyeleksianModel;
import mosing.model.ProvinsiModel;
import mosing.model.UserAdmisiModel;
import mosing.service.JalurMasukService;
import mosing.service.KotaService;
import mosing.service.PendaftarService;
import mosing.service.PenyeleksianService;
import mosing.service.ProvinsiService;
import mosing.service.UserAdmisiService;

//testing
@Controller
public class PageController {
	@Autowired
	UserAdmisiService userDAO;

	@Autowired
	JalurMasukService jalurMasukDAO;

	@Autowired
	ProvinsiService provinsiDAO;

	@Autowired
	KotaService kotaDAO;

	@Autowired
	PendaftarService pendaftarDAO;

	@Autowired
	PenyeleksianService penyeleksianDAO;

	@RequestMapping("/")
	public String login(Model model) {
		UserAdmisiModel user = userDAO.selectUser();
		model.addAttribute("user", user);
		if (user != null) {
			if (user.getRole().equalsIgnoreCase("ROLE_PEND")) {
				String username = user.getUsername();
				PendaftarModel pendaftar = new PendaftarModel();
				PenyeleksianModel penyeleksian = new PenyeleksianModel();
				if (pendaftarDAO.selectPendaftar2(username) != null) {
					pendaftar = pendaftarDAO.selectPendaftar2(username);
					if (penyeleksianDAO.selectPenyeleksian2(pendaftar.getNo_daftar()) != null) {
						penyeleksian = penyeleksianDAO.selectPenyeleksian2(pendaftar.getNo_daftar());
						pendaftarDAO.deletePendaftar(pendaftar.getNo_daftar());
						penyeleksianDAO.deletePenyeleksian(penyeleksian);
						return "redirect:/";
					}
					else if (user.getEmail() != null) {
						return "home";
					} else {
						List<JalurMasukModel> jalurMasuk = jalurMasukDAO.selectAllJalurTulis();
						List<ProvinsiModel> allProvinsi = provinsiDAO.selectAllProvinsi();
						List<KotaModel> allKota = kotaDAO.selectKotaIndo();
						model.addAttribute("username", username);
						model.addAttribute("jalurMasuk", jalurMasuk);
						model.addAttribute("allProvinsi", allProvinsi);
						model.addAttribute("allKota", allKota);
						return "form-lengkapiData";
					}
				} else {
					List<JalurMasukModel> jalurMasuk = jalurMasukDAO.selectAllJalurTulis();
					List<ProvinsiModel> allProvinsi = provinsiDAO.selectAllProvinsi();
					List<KotaModel> allKota = kotaDAO.selectKotaIndo();
					model.addAttribute("username", username);
					model.addAttribute("jalurMasuk", jalurMasuk);
					model.addAttribute("allProvinsi", allProvinsi);
					model.addAttribute("allKota", allKota);
					return "form-registrasi2";
				}
			} else {
				return "home";
			}
		} else {
			return "index";
		}
	}

	@RequestMapping("/login")
	public String login() {
		return "login";
	}
}