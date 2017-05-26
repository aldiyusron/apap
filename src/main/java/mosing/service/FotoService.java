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
import mosing.model.PendaftarModel;

@Service
public class FotoService {

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	PendaftarMapper pendaftarMapper;
	
	public void insert(PendaftarModel pendaftar) throws IOException {
		
		String pathname = "/src/main/webapp/foto/" + pendaftar.getNo_daftar() + pendaftar.getPhoto().getOriginalFilename();
		
		/* for deploy */
		//String pathname = "/opt/tomcat/webapps/a6/foto/" + pendaftar.getNo_daftar() + pendaftar.getPhoto().getOriginalFilename();
		
		byte[] bytes = pendaftar.getPhoto().getBytes();
		Path path = Paths.get(pathname);
		Files.write(path, bytes);
		
		pathname = pendaftar.getNo_daftar() + pendaftar.getPhoto().getOriginalFilename();
		
		pendaftar.setFoto(pathname);
		
		pendaftarMapper.updateFoto(pendaftar.getFoto(), pendaftar.getNo_daftar());
	}
}
