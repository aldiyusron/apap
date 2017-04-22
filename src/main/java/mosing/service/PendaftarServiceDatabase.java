package mosing.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.PendaftarMapper;
import mosing.model.PendaftarModel;

@Slf4j
@Service
public class PendaftarServiceDatabase implements PendaftarService {
	
	@Autowired
	PendaftarMapper pendaftarMapper;
	
	@Override
	public PendaftarModel selectPendaftar (String no_id)
	{
		return pendaftarMapper.selectPendaftar(no_id);
	}
	
	@Override
	public void addPendaftar (PendaftarModel pendaftar)
	{
		pendaftarMapper.addPendaftar (pendaftar);
	}

	@Override
	public void addPendaftar2(PendaftarModel pendaftar) {
		pendaftarMapper.addPendaftar2(pendaftar);
	}
}
