package mosing.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.RiwayatPendaftaranMapper;
import mosing.model.RiwayatPendaftaranModel;

@Slf4j
@Service
public class RiwayatPendaftaranServiceDatabase implements RiwayatPendaftaranService{
	@Autowired
	RiwayatPendaftaranMapper riwayatMapper;
	
	@Override
	public void addRiwayat(RiwayatPendaftaranModel riwayat) {
		riwayatMapper.addRiwayat(riwayat);
	}

	@Override
	public RiwayatPendaftaranModel viewRiwayat(int no_daftar) {
		return riwayatMapper.viewRiwayat(no_daftar);
	}

}
