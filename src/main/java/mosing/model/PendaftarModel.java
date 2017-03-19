package mosing.model;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class PendaftarModel {

	private String username;
	private String no_id;
	private String nama_id;
	private String nama_ijazah;
	private String foto;
	private String no_hp;
	private String no_telp;
	private String negara;
	private String kewarganegaraan;
	private String alamat_tetap;
	private String jenis_id;
	private String alamat_sekarang;
	private Date tgl_lahir;
	private String provinsi;
	private String kota;
	private byte jenis_kelamin;
//	private String no_daftar;
//	private String no_ujian;

//	public PendaftarModel(UserAdmisiModel user, String no_id, String nama_id, String nama_ijazah, String foto,
//			String no_hp, String no_telp, String negara, String kewarganegaraan, String alamat_tetap, String jenis_id,
//			String alamat_sekarang, Date tgl_lahir, String provinsi, String kota, byte jenis_kelamin, String no_daftar,
//			String no_ujian) {
//		this.user = user;
//		this.username = user.getUsername();
//		this.no_id = no_id;
//		this.nama_id = nama_id;
//		this.nama_ijazah = nama_ijazah;
//		this.foto = foto;
//		this.no_hp = no_hp;
//		this.no_telp = no_telp;
//		this.negara = negara;
//		this.kewarganegaraan = kewarganegaraan;
//		this.alamat_tetap = alamat_tetap;
//		this.jenis_id = jenis_id;
//		this.alamat_sekarang = alamat_sekarang;
//		this.tgl_lahir = tgl_lahir;
//		this.provinsi = provinsi;
//		this.kota = kota;
//		this.jenis_kelamin = jenis_kelamin;
//		this.no_daftar = no_daftar;
//		this.no_ujian = no_ujian;
//	}
}
