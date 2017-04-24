package mosing.service;

import java.util.List;

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
		jalurMasukMapper.deleteJalurMasuk(jalurMasuk);
	}

	@Override
	public JalurMasukModel selectJalurMasuk(int id_jalur) {
		return jalurMasukMapper.selectJalurMasuk(id_jalur);
	}
	
	@Override
	public List<JalurMasukModel> selectAllJalurMasuk() {
		return jalurMasukMapper.selectAllJalurMasuk();
	}
}
