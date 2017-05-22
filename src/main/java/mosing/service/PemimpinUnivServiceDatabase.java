package mosing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.PUnivMapper;
import mosing.mapper.PendaftarMapper;
import mosing.model.PendaftarModel;

@Service
@Slf4j
public class PemimpinUnivServiceDatabase implements PemimpinUnivService {
	
	@Autowired
	PUnivMapper punivMapper;
	
	@Override
	public List<PendaftarModel> selectAllPendaftar() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarLulus(int status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarS1(int jenjang) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarS1Lulus(int status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarS2(int jenjang) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarS2Lulus(int status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarS3(int jenjang) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarS3Lulus(int status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarReguler(int nama_program) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarRegulerLulus(int status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarParalel(int nama_program) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarParalelLulus(int status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarInternasional(int nama_program) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarInternasionalLulus(int status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarFakultas(int id_prodi) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarFakultasLulus(int status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarProdi(int id_prodi) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarProdiLulus(int status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarSNMPTN(int id_jalur) {
		// TODO Auto-generated method stub
		return punivMapper.selectAllPendaftarSNMPTN(id_jalur);
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarSNMPTNLulus(int status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarPPKB(int id_jalur) {
		// TODO Auto-generated method stub
		return punivMapper.selectAllPendaftarPPKB(id_jalur);
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarPPKBLulus(int status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarTalentScouting(int id_jalur) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarTalentScoutingLulus(int status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarSIMAK(int id_jalur) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftatSIMAKLulus(int status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarOlim(int id_jalur) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PendaftarModel> selectAllPendaftarOlimLulus(int status) {
		// TODO Auto-generated method stub
		return null;
	}

}
