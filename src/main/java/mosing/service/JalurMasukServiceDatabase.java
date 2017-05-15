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
	public JalurMasukModel selectJalurMasuk(int id_jalur)
	{
		return JalurMasukMapper.selectJalurMasuk(id_jalur);
	}

	@Override
	public List<JalurMasukModel> selectAllJalurMasuk() {
		return JalurMasukMapper.selectAllJalurMasuk();
	}
	
	@Override
	public List<ProdiTersediaModel> selectProdiJalurMasuk(int id_jalur) {
		return JalurMasukMapper.selectProdiJalurMasuk(id_jalur);
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
	public void deleteJalurMasuk(int id_jalur) {
		JalurMasukMapper.deleteJalurMasuk(id_jalur);
	}
	
	@Override
	public List<ProdiTersediaModel> selectAllProdi(int id_jalur)
	{
		return JalurMasukMapper.selectAllProdi(id_jalur);
	}
	
	@Override
	public List<JalurMasukModel> selectAllJalurTulis()
	{
		return JalurMasukMapper.selectAllJalurTulis();
	}
	
	@Override
	public List<JalurMasukModel> selectAllJalurUndangan()
	{
		return JalurMasukMapper.selectAllJalurUndangan();
	}

	@Override
	public JalurMasukModel selectJalur(String nama_jalur) {
		// TODO Auto-generated method stub
		return JalurMasukMapper.selectJalur(nama_jalur);
	}
}