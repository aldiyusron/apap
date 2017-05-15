package mosing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.KotaMapper;
import mosing.model.KotaModel;

@Slf4j
@Service
public class KotaServiceDatabase implements KotaService {
	
	@Autowired
	KotaMapper kotaMapper;
	
	@Override
	public KotaModel selectKota(int id_kota) {
		return kotaMapper.selectKota(id_kota);
	}

	@Override
	public List<KotaModel> selectAllKota(int id_provinsi) {
		return kotaMapper.selectAllKota(id_provinsi);
	}

	@Override
	public List<KotaModel> selectKotaIndo() {
		return kotaMapper.selectKotaIndo();
	}

}
