package mosing.controller;

import mosing.model.PendaftarModel;
import mosing.model.PenyeleksianModel;
import mosing.service.PendaftarService;
import mosing.service.PenyeleksianService;
import mosing.service.StorageFileNotFoundException;
import mosing.service.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.util.stream.Collectors;

@Controller
public class FileUploadController {

	private final StorageService storageService;
	@Autowired
	PendaftarService pendaftarDAO;

	@Autowired
	PenyeleksianService penyeleksianDAO;

	@Autowired
	public FileUploadController(StorageService storageService) {
		this.storageService = storageService;
	}

	@GetMapping("/pendaftar/uploadfoto/{username}")
	public String listUploadedFoto(Model model, @PathVariable(value = "username") String username) throws IOException {

		model.addAttribute("files",
				storageService.loadAll()
						.map(path -> MvcUriComponentsBuilder
								.fromMethodName(FileUploadController.class, "serveFile", path.getFileName().toString())
								.build().toString())
						.collect(Collectors.toList()));

		return "uploadForm";
	}

//	@GetMapping("/pendaftar/uploadberkas/{username}")
//	public String listUploadedBerkas(Model model, @PathVariable(value = "username") String username) throws IOException {
//
//		model.addAttribute("files",
//				storageService.loadAll()
//						.map(path -> MvcUriComponentsBuilder
//								.fromMethodName(FileUploadController.class, "serveFile", path.getFileName().toString())
//								.build().toString())
//						.collect(Collectors.toList()));
//
//		return "uploadFormBerkas";
//	}
	
	@GetMapping("/files/{filename:.+}")
	@ResponseBody
	public ResponseEntity<Resource> serveFile(@PathVariable String filename) {

		Resource file = storageService.loadAsResource(filename);
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + file.getFilename() + "\"")
				.body(file);
	}

	@PostMapping("/pendaftar/uploadfoto/{username}")
	public String handleFotoUpload(Model model, @PathVariable(value = "username") String username,
			@RequestParam("file") MultipartFile file, RedirectAttributes redirectAttributes) {

		storageService.store(file);
		redirectAttributes.addFlashAttribute("message",
				"Kamu telah berhasil mengunggah " + file.getOriginalFilename() + "!");
		PendaftarModel pendaftar = pendaftarDAO.selectPendaftar2(username);
		String foto = file.getOriginalFilename();
		pendaftarDAO.updateFoto(foto, pendaftar.getId_user());
		return "redirect:/pendaftar/uploadfoto/" + username;
	}
	
//	@PostMapping("/pendaftar/uploadberkas/{username}")
//	public String handleBerkasUpload(Model model, @PathVariable(value = "username") String username,
//			@RequestParam("file") MultipartFile file, RedirectAttributes redirectAttributes) {
//
//		storageService.store(file);
//		redirectAttributes.addFlashAttribute("message",
//				"You successfully uploaded " + file.getOriginalFilename() + "!");
//		PendaftarModel pendaftar = pendaftarDAO.selectPendaftar(username);
//		PenyeleksianModel penyeleksian = penyeleksianDAO.selectPenyeleksian2(pendaftar.getNo_daftar());
//		String berkas = file.getOriginalFilename();
//		penyeleksianDAO.updateBerkas(berkas, penyeleksian.getNo_daftar());
//		return "redirect:/pendaftar/uploadberkas/{username}";
//	}
	
	@RequestMapping("/pendaftar/suksesdaftarseleksi")
	public String success() {
		return "sudahdaftarseleksi";
	}

	@ExceptionHandler(StorageFileNotFoundException.class)
	public ResponseEntity handleStorageFileNotFound(StorageFileNotFoundException exc) {
		return ResponseEntity.notFound().build();
	}

}