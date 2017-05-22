package mosing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.PengawasUjianMapper;
import mosing.model.PengawasUjianModel;

@Slf4j
@Service
public class PengawasUjianServiceDatabase implements PengawasUjianService {

	@Autowired
	PengawasUjianMapper pengawasMapper;

	@Override
	public void addPengawas(PengawasUjianModel pengawas) {
		pengawasMapper.addPengawas(pengawas);
	}

	@Override
	public PengawasUjianModel selectPengawas(String username) {
		return pengawasMapper.selectPengawas(username);
	}

	@Override
	public List<PengawasUjianModel> selectAllPengawas() {
		return pengawasMapper.selectAllPengawas();
	}
	
	@Override
	public void terimaPengawas(int id_user) {
		pengawasMapper.terimaPengawas(id_user);
	}
	
	@Override
	public void updatePengawas(PengawasUjianModel pengawas) {
		pengawasMapper.updatePengawas(pengawas);
	}

	@Override
	public List<PengawasUjianModel> selectPengawasUjianTerseleksi(int id_lokasi) {
		return pengawasMapper.selectPengawasUjianTerseleksi(id_lokasi);
	}

	@Override
	public List<PengawasUjianModel> selectPengawasUjianLokasi(int id_lokasi) {
		return pengawasMapper.selectPengawasUjianLokasi(id_lokasi);
	}

	@Override
	public void tolakPengawas(PengawasUjianModel pengawas) {
		pengawasMapper.tolakPengawas(pengawas);
	}

	@Override
	public PengawasUjianModel selectPengawasPindah(int id_user) {
		return pengawasMapper.selectPengawasPindah(id_user);
	}
}
