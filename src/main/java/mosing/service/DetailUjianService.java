package mosing.service;

import java.util.List;

import mosing.model.DetailUjianModel;

public interface DetailUjianService {
	DetailUjianModel selectDetail(int id_jalur);
//	DetailUjianModel selectDetailS1(int id_jalur);
//	DetailUjianModel selectDetailPascasarjana(int id_jalur);
	List<DetailUjianModel> selectAllDetail();
	void addDetail(DetailUjianModel detail);
}