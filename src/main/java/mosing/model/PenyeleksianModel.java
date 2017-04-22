package mosing.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PenyeleksianModel {

	private String no_daftar;
	private int status;
	private String id_jalur;
	private String berkas;
}
