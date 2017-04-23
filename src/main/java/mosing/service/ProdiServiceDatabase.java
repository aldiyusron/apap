package mosing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.ProdiMapper;
import mosing.model.JalurMasukModel;
import mosing.model.ProdiModel;
import mosing.service.JalurMasukService;

@Slf4j
@Service
public class ProdiServiceDatabase implements ProdiService {
	@Autowired
	ProdiMapper ProdiMapper;
	
//	@Override
//	public JalurMasukModel selectJalurMasuk(int id_jalur)
//	{
//		return JalurMasukMapper.selectJalurMasuk(id_jalur);
//	}

	@Override
	public List<ProdiModel> selectAllProdi(int id_jalur) {
		return ProdiMapper.selectAllProdi(id_jalur);
	}
	
//	@Override
//	public List<ProdiModel> selectProdiJalurMasuk() {
//		return JalurMasukMapper.selectProdiJalurMasuk();
//	}

//	@Override
//	public void addJalurMasuk(JalurMasukModel jalur_masuk) {
//		JalurMasukMapper.addJalurMasuk (jalur_masuk);
//	}
//	
//	@Override
//	public void updateJalurMasuk(JalurMasukModel jalur_masuk) {
//		JalurMasukMapper.updateJalurMasuk (jalur_masuk);
//	}
}
