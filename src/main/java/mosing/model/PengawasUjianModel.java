package mosing.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PengawasUjianModel extends UserAdmisiModel {

	public PengawasUjianModel(String username2, String password2, String email2, String string) {
		super(username2, password2, email2, string);
		// TODO Auto-generated constructor stub
	}
	private boolean status;
	private String jabatan;
	private String nama;
	private LokasiModel lokasi;
}
