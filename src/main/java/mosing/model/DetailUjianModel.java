package mosing.model;

import java.sql.Time;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DetailUjianModel {
	private int no_daftar;
	private String no_ujian;
	private int id_jalur;
	private int id_lokasi;
	private Time waktu_ujian;
	private Date tanggal_ujian;
}