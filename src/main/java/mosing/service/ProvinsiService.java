package mosing.service;

import java.util.List;

import mosing.model.ProvinsiModel;

public interface ProvinsiService {
	List<ProvinsiModel> selectAllProvinsi();
	ProvinsiModel selectProvinsi(int id_provinsi);
	
}
