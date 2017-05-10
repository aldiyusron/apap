package mosing.service;

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
}
