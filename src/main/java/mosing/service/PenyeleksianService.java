package mosing.service;

import java.util.List;
import mosing.model.PenyeleksianModel;

public interface PenyeleksianService {
	void addPenyeleksian(PenyeleksianModel penyeleksian);
	PenyeleksianModel selectPenyeleksian(int id_jalur);
	PenyeleksianModel selectPenyeleksian2(int no_daftar);
	void updateBerkas(String berkas, int no_daftar);
	List<PenyeleksianModel> selectAllPenyeleksian();
	void updatePenyeleksian(int no_daftar);
	void updateLulus(int no_daftar);
}
