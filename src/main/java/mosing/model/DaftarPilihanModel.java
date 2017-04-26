package mosing.model;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DaftarPilihanModel {

	private int no_daftar;
	private String jenjang;
	private String nama_program;
	private int id_prodi;
	private int pilihan;
}
