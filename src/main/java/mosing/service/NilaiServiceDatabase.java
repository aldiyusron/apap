package mosing.service;

import java.util.List;

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

	@Override
	public void updateNilai(NilaiModel nilai) {
		nilaiMapper.updateNilai(nilai);
		
	}
	
	@Override
	public List<NilaiModel> selectNilai(int no_daftar) {
		return nilaiMapper.selectNilai(no_daftar);
	}
}
