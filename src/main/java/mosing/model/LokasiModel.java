package mosing.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LokasiModel {

	private int id_lokasi;
	private int id_jalur;
	private String alamat;
	private String no_telp;
	private String nama_lokasi;
	private String nama_provinsi;
	private String nama_kota;
	private int kuota_peng;
	private int kuota_pendaftar;
	private int flag_aktif;
	private List<PengawasUjianModel> listPengawas;
}
