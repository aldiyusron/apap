package mosing.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FakultasModel {
	private int id_fakultas;
	private String fakultas;
	private List<ProdiTersediaModel> listProdi;
	

}
