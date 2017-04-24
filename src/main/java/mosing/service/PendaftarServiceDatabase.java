package mosing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.PendaftarMapper;
import mosing.model.PendaftarModel;

@Slf4j
@Service
public class PendaftarServiceDatabase implements PendaftarService {
	
	@Autowired
	PendaftarMapper pendaftarMapper;
	
	@Override
	public PendaftarModel selectPendaftar (String no_id)
	{
		return pendaftarMapper.selectPendaftar(no_id);
	}
	
	@Override
	public void addPendaftar (PendaftarModel pendaftar)
	{
		pendaftarMapper.addPendaftar (pendaftar);
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarTerverifikasi(Integer id_value) {
		// TODO Auto-generated method stub
		return pendaftarMapper.selectAllPendaftarTerverifikasi(id_value);
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarTakTerverifikasi(Integer id_value) {
		// TODO Auto-generated method stub
		return pendaftarMapper.selectAllPendaftarTakTerverifikasi(id_value);
	}
	
	public List<PendaftarModel> selectAllPendaftar() {
		// TODO Auto-generated method stub
		return pendaftarMapper.selectAllPendaftar();
	}

	@Override
	public List<PendaftarModel> selectTakTerverifikasi() {
		// TODO Auto-generated method stub
		return pendaftarMapper.selectTakTerverifikasi();
	}

	@Override
	public List<PendaftarModel> selectTerverifikasi() {
		// TODO Auto-generated method stub
		return pendaftarMapper.selectTerverifikasi();	}
	
}
