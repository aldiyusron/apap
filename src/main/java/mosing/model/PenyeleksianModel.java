package mosing.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PenyeleksianModel {

	private int no_daftar;
	private byte status;
	private int id_jalur;
	private byte status_rekomen;
	private String berkas;
}
