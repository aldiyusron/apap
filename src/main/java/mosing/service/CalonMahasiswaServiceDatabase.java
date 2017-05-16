package mosing.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.model.CalonMahasiswaModel;
import mosing.mapper.CalonMahasiswaMapper;

@Service
@Slf4j
public class CalonMahasiswaServiceDatabase implements CalonMahasiswaService{

	@Autowired
	CalonMahasiswaMapper CalonMahasiswaMapper;
	
	@Override
	public CalonMahasiswaModel selectCalon(int no_daftar) {
		// TODO Auto-generated method stub
		return CalonMahasiswaMapper.selectCalon(no_daftar);
	}

}
