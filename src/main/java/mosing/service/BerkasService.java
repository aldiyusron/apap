package mosing.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mosing.mapper.PendaftarMapper;
import mosing.mapper.PenyeleksianMapper;
import mosing.model.PendaftarModel;
import mosing.model.PenyeleksianModel;

@Service
public class BerkasService {

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	PenyeleksianMapper penyeleksianMapper;
	
	public void insert(PenyeleksianModel penyeleksian) throws IOException {
		
		String pathname = "foto/" + penyeleksian.getNo_daftar() + penyeleksian.getFileBerkas().getOriginalFilename();
		
		byte[] bytes = penyeleksian.getFileBerkas().getBytes();
		Path path = Paths.get(pathname);
		Files.write(path, bytes);
		
		pathname = penyeleksian.getNo_daftar() + penyeleksian.getFileBerkas().getOriginalFilename();
		
		penyeleksian.setBerkas(pathname);
		
		penyeleksianMapper.updateBerkas(penyeleksian.getBerkas(), penyeleksian.getNo_daftar());
	}
}
