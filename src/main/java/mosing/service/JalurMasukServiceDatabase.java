package mosing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.JalurMasukMapper;
import mosing.model.JalurMasukModel;
import mosing.model.ProdiTersediaModel;
import mosing.service.JalurMasukService;

@Slf4j
@Service
public class JalurMasukServiceDatabase implements JalurMasukService {
	@Autowired
	JalurMasukMapper JalurMasukMapper;
	
	@Override
	public List<JalurMasukModel> selectAllJalurUndangan()
	{
		return JalurMasukMapper.selectAllJalurUndangan();
	}
	
	@Override
	public List<JalurMasukModel> selectAllJalurMasuk() {
		return JalurMasukMapper.selectAllJalurMasuk();
	}

	@Override
	public void addJalurMasuk(JalurMasukModel jalur_masuk) {
		JalurMasukMapper.addJalurMasuk (jalur_masuk);
	}
	
	@Override
	public void updateJalurMasuk(JalurMasukModel jalur_masuk) {
		JalurMasukMapper.updateJalurMasuk (jalur_masuk);
	}
	
	@Override
	public List<ProdiTersediaModel> selectAllProdi(int id_jalur)
	{
		return JalurMasukMapper.selectAllProdi(id_jalur);
	}

	@Override
	public JalurMasukModel selectJalurMasuk(int id_jalur) {
		// TODO Auto-generated method stub
		return JalurMasukMapper.selectJalurMasuk(id_jalur);
	}

	@Override
	public JalurMasukModel selectJalur(String nama_jalur) {
		// TODO Auto-generated method stub
		return JalurMasukMapper.selectJalur(nama_jalur);
	}
}