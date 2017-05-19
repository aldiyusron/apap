package mosing.model;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class PendaftarModel {
	private int id_user;
	private String no_id;
	private String nama_id;
	private String nama_ijazah;
	private MultipartFile photo;
	private String foto;
	private String no_hp;
	private String no_telp;
	private String nama_negara;
	private String kewarganegaraan;
	private String alamat_tetap;
	private String jenis_id;
	private String alamat_sekarang;
	private Date tgl_lahir;
	private String nama_provinsi;
	private String nama_kota;
	private byte jenis_kelamin;
	private int no_daftar;
	private String nama_lembaga;
	private String jurusan;
	private double rata2;
}