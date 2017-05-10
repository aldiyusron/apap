package mosing.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LPTerdahuluModel {
	private int id_user;
	private String nama_lembaga;
	private String nama_provinsi;
	private String nama_kota;
}
