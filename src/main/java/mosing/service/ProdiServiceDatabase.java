package mosing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.ProdiMapper;
import mosing.model.ProdiTersediaModel;

@Slf4j
@Service
public class ProdiServiceDatabase implements ProdiService {

	@Autowired
	ProdiMapper prodiMapper;
	
	@Override
	public ProdiTersediaModel selectProdi(int id_prodi)
	{
		return prodiMapper.selectProdi(id_prodi);
	}
	
	@Override
	public List<ProdiTersediaModel> selectAllProdi(String id_jalur)
	{
		return prodiMapper.selectAllProdi(id_jalur);
	}
}
