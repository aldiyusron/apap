package mosing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.ProvinsiMapper;
import mosing.model.ProvinsiModel;

@Slf4j
@Service
public class ProvinsiServiceDatabase implements ProvinsiService {
	
	@Autowired
	ProvinsiMapper provinsiMapper;
	
	@Override
	public List<ProvinsiModel> selectAllProvinsi() {
		return provinsiMapper.selectAllProvinsi();
	}

	@Override
	public ProvinsiModel selectProvinsi(int id_provinsi) {
		return provinsiMapper.selectProvinsiDanKotanya(id_provinsi);
	}

}
