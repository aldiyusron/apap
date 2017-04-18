package mosing.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.JalurMasukMapper;
import mosing.model.JalurMasukModel;

@Slf4j
@Service
public class JalurMasukServiceDatabase implements JalurMasukService {

	@Autowired
	JalurMasukMapper jalurMasukMapper;
	
	@Override
	public void deleteJalurMasuk(JalurMasukModel jalurMasuk) {
		// TODO Auto-generated method stub
		jalurMasukMapper.deleteJalurMasuk(jalurMasuk);
	}

	@Override
	public JalurMasukModel selectJalurMasuk(int id_jalur) {
		// TODO Auto-generated method stub
		return jalurMasukMapper.selectJalurMasuk(id_jalur);
	}

}
