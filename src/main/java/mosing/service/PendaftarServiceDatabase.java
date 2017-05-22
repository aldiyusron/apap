package mosing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.PendaftarMapper;
import mosing.model.DaftarPilihanModel;
import mosing.model.PendaftarModel;

@Slf4j
@Service
public class PendaftarServiceDatabase implements PendaftarService {

	@Autowired
	PendaftarMapper pendaftarMapper;

	@Override
	public PendaftarModel selectPendaftar2(String username) {
		return pendaftarMapper.selectPendaftar2(username);
	}

	@Override
	public PendaftarModel selectPendaftar(String no_id) {
		return pendaftarMapper.selectPendaftar(no_id);
	}

	@Override
	public void addPendaftar(PendaftarModel pendaftar) {
		pendaftarMapper.addPendaftar(pendaftar);
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarTerverifikasi() {
		// TODO Auto-generated method stub
		return pendaftarMapper.selectAllPendaftarTerverifikasi();
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarTakTerverifikasi() {
		// TODO Auto-generated method stub
		return pendaftarMapper.selectAllPendaftarTakTerverifikasi();
	}

	public List<PendaftarModel> selectAllPendaftar() {
		// TODO Auto-generated method stub
		return pendaftarMapper.selectAllPendaftar();
	}

	@Override
	public void updateDataPendaftar(PendaftarModel pendaftar) {
		// TODO Auto-generated method stub
		pendaftarMapper.updateDataPendaftar(pendaftar);
	}

	@Override
	public PendaftarModel selectPPKB(String no_id) {
		return pendaftarMapper.selectPPKB(no_id);
	}

	@Override
	public PendaftarModel selectPendaftarLulus(int no_daftar) {
		return pendaftarMapper.selectPendaftarLulus(no_daftar);
	}

	@Override
	public void addDaftarPilihan(DaftarPilihanModel daftar) {
		pendaftarMapper.addDaftarPilihan(daftar);
	}

	@Override
	public void updateFoto(String foto, int no_daftar) {
		pendaftarMapper.updateFoto(foto, no_daftar);
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarPPKB() {
		// TODO Auto-generated method stub
		return pendaftarMapper.selectAllPendaftarPPKB();
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarNonRec(int id_prodi) {
		// TODO Auto-generated method stub
		return pendaftarMapper.selectAllPendaftarNonRec(id_prodi);
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarRec(int id_fakultas) {
		// TODO Auto-generated method stub
		return pendaftarMapper.selectAllPendaftarRec(id_fakultas);
	}

	@Override
	public PendaftarModel selectNama(int no_daftar) {
		return pendaftarMapper.selectNama(no_daftar);
	}

	@Override
	public void deletePendaftar(int no_daftar) {
		// TODO Auto-generated method stub
		pendaftarMapper.deletePendaftar(no_daftar);
	}

	@Override
	public void updateDataDiriLengkap(PendaftarModel pendaftar) {
		// TODO Auto-generated method stub
		pendaftarMapper.updateDataDiriLengkap(pendaftar);
	}
	
	@Override
	public List<PendaftarModel> selectAllPendaftarSemua(int id_prodi, int id_jalur) {
		// TODO Auto-generated method stub
		return pendaftarMapper.selectAllPendaftarSemua(id_prodi, id_jalur);
	}

	@Override
	public PendaftarModel selectPendaftar3(int no_daftar) {
		// TODO Auto-generated method stub
		return pendaftarMapper.selectPendaftar3(no_daftar);
	}
}
