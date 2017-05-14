package mosing.service;

import java.util.List;

import mosing.mapper.PUnivMapper;
import mosing.model.CalonMahasiswaModel;

public class PUnivServiceDatabase {
	public List<CalonMahasiswaModel> selectAllPUniv() {
		// TODO Auto-generated method stub
		return PUnivMapper.selectAllPUniv();
	}

	public void updateCalonMahasiswa(CalonMahasiswaModel PUniv) {
		// TODO Auto-generated method stub
		PUnivMapper.updateCalonMahasiswa(PUniv);
	}
}
