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
	public LokasiModel selectLokasi(String nama_lokasi)
	{
		return lokasiMapper.selectLokasi(nama_lokasi);
	}
	
	@Override
	public List<LokasiModel> selectAllLokasi()
	{
		return lokasiMapper.selectAllLokasi();
	}
}
