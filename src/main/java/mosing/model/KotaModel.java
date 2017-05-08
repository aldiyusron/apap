package mosing.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class KotaModel {
	private int id_kota;
	private int id_provinsi;
	private String nama_kota;
}
