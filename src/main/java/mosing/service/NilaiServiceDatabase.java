package mosing.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.NilaiMapper;
import mosing.model.NilaiModel;

@Slf4j
@Service
public class NilaiServiceDatabase implements NilaiService{

	@Autowired
	NilaiMapper nilaiMapper;
	
	@Override
	public void addNilai(NilaiModel nilai)
	{
		nilaiMapper.addNilai(nilai);
	}
}
