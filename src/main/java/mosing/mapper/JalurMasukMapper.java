package mosing.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import mosing.model.JalurMasukModel;

@Mapper
public interface JalurMasukMapper {
	
	@Update("update jalur_masuk set flag=0 where id_jalur=#{id_jalur}")
	void deleteJalurMasuk(JalurMasukModel jalurMasuk);
	@Select("select * from Jalur_masuk where id_jalur=#{id_jalur}") 
	JalurMasukModel selectJalurMasuk(String id_jalur);
}
