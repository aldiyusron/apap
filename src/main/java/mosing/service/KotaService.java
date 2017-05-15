package mosing.service;

import java.util.List;

import mosing.model.KotaModel;

public interface KotaService {
	KotaModel selectKota(int id_kota);
	List<KotaModel> selectAllKota(int id_provinsi);
	List<KotaModel> selectKotaIndo();
}
