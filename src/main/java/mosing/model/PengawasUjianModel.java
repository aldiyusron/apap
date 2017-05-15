package mosing.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PengawasUjianModel {
	
	private int id_user;
	private boolean status;
	private String jabatan;
	private String nama;
	private String no_hp;
	private int id_lokasi;
	private byte pindah_bool;
}
