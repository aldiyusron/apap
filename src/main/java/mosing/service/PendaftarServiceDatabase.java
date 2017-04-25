package mosing.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.PendaftarMapper;
import mosing.model.DaftarPilihanModel;
import mosing.model.PendaftarModel;
import mosing.model.PenyeleksianModel;

@Slf4j
@Service
public class PendaftarServiceDatabase implements PendaftarService {
	
	@Autowired
	PendaftarMapper pendaftarMapper;
	
	@Override
	public PendaftarModel selectPendaftar (String username)
	{
		return pendaftarMapper.selectPendaftar(username);
	}
	
	@Override
	public void addPendaftar (PendaftarModel pendaftar)
	{
		pendaftarMapper.addPendaftar (pendaftar);
	}
	
	@Override
	public void addDaftarPilihan (DaftarPilihanModel daftar)
	{
		pendaftarMapper.addDaftarPilihan(daftar);
	}
	
	@Override
	public void updateFoto(String foto, String id_user)
	{
		pendaftarMapper.updateFoto(foto, id_user);
	}
}
