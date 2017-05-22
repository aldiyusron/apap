package mosing.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RiwayatPendaftaranModel {

	private int no_pendaftaran;
	private String tahun;
	private int id_jalur;
	private String nama_jenjang;
	private String nama_program;
}
