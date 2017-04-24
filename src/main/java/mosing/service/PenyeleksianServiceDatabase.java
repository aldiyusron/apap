package mosing.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.PenyeleksianMapper;
import mosing.model.PenyeleksianModel;

@Slf4j
@Service
public class PenyeleksianServiceDatabase implements PenyeleksianService {
	@Autowired
	PenyeleksianMapper penyeleksianMapper;
	
	@Override
	public void addPenyeleksian(PenyeleksianModel penyeleksian) {
		penyeleksianMapper.addPenyeleksian(penyeleksian);
	}
	
	@Override
	public PenyeleksianModel selectPenyeleksian(int id_jalur)
	{
		return penyeleksianMapper.selectPenyeleksian(id_jalur);
	}

	@Override
	public PenyeleksianModel selectPenyeleksian2(int no_daftar)
	{
		return penyeleksianMapper.selectPenyeleksian2(no_daftar);
	}
	
	@Override
	public void updateBerkas(String berkas, int no_daftar)
	{
		penyeleksianMapper.updateBerkas(berkas, no_daftar);
	}
}