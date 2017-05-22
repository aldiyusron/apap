package mosing.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import mosing.mapper.DetailUjianMapper;
import mosing.model.DetailUjianModel;

@Slf4j
@Service
public class DetailUjianServiceDatabase implements DetailUjianService {
	
	@Autowired
	DetailUjianMapper detailUjianMapper;

	@Override
	public DetailUjianModel selectDetail(int id_jalur) {
		return detailUjianMapper.selectDetail(id_jalur);
	}

	@Override
	public List<DetailUjianModel> selectAllDetail() {
		// TODO Auto-generated method stub
		return detailUjianMapper.selectAllDetail();
	}

	@Override
	public void addDetail(DetailUjianModel detail) {
		// TODO Auto-generated method stub
		detailUjianMapper.addDetail(detail);
	}
	
//	@Override
//	public DetailUjianModel selectDetailS1(int id_jalur) {
//		return detailUjianMapper.selectDetailS1(id_jalur);
//	}
//
//	@Override
//	public DetailUjianModel selectDetailPascasarjana(int id_jalur) {
//		return detailUjianMapper.selectDetailPascasarjana(id_jalur);
//	}

}