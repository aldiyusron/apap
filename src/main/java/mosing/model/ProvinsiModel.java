package mosing.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProvinsiModel {
	private int id_provinsi;
	private int id_negara;
	private String nama_provinsi;
	private List<KotaModel> listKota;
}
