package mosing.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProdiTersediaModel {

	private String nama_prodi;
	private int daya_tampung;
	private int id_fakultas;
	private int id_jalur;
}
