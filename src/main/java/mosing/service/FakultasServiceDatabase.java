package mosing.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.FakultasMapper;
import mosing.model.FakultasModel;

@Slf4j
@Service
public class FakultasServiceDatabase implements FakultasService {
	@Autowired
	FakultasMapper FakultasDAO;

	@Override
	public FakultasModel selectFakultas(int id_fakultas) {
		return FakultasDAO.selectFakultas(id_fakultas);
	}

	@Override
	public List<FakultasModel> selectAllFakultas() {
		return FakultasDAO.selectAllFakultas();
	}

}
