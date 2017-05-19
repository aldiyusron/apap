package mosing.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.model.CalonMahasiswaModel;
import mosing.mapper.CalonMahasiswaMapper;
import mosing.mapper.PendaftarMapper;

@Service
@Slf4j
public class CalonMahasiswaServiceDatabase implements CalonMahasiswaService{

	@Autowired
	CalonMahasiswaMapper CalonMahasiswaMapper;
	
	@Autowired
	PendaftarMapper PendaftarMapper;
	
	@Override
	public CalonMahasiswaModel selectCalon(int no_daftar) {
		// TODO Auto-generated method stub
		return CalonMahasiswaMapper.selectCalon(no_daftar);
	}
	
	@Override
	public void addCalon(CalonMahasiswaModel calon) {
		CalonMahasiswaMapper.addCalon(calon);
		
	}

}
