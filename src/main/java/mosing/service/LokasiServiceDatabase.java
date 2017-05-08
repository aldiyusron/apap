package mosing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.LokasiMapper;
import mosing.model.LokasiModel;

@Slf4j
@Service
public class LokasiServiceDatabase implements LokasiService {

	@Autowired
	LokasiMapper lokasiMapper;
	
	@Override
	public LokasiModel selectLokasi(int id_lokasi)
	{
		return lokasiMapper.selectLokasi(id_lokasi);
	}
	
	@Override
	public List<LokasiModel> selectAllLokasi()
	{
		return lokasiMapper.selectAllLokasi();
	}

	@Override
	public void addLokasiUjian(LokasiModel lokasi) {
		lokasiMapper.addLokasiUjian(lokasi);
	}

	@Override
	public void updateLokasiUjian(LokasiModel lokasi) {
		lokasiMapper.updateLokasiUjian(lokasi);
	}

	@Override
	public void deleteLokasiUjian(LokasiModel lokasi) {
		lokasiMapper.deleteLokasiUjian(lokasi);
	}

	@Override
	public List<LokasiModel> selectLokasiJalur(int id_jalur) {
		return lokasiMapper.selectLokasiJalur(id_jalur);
	}
}
