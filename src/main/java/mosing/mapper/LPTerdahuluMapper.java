package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Select;

import mosing.model.NilaiModel;
import mosing.model.LPTerdahuluModel;

@Mapper
public interface LPTerdahuluMapper {

	@Insert("INSERT INTO nilai_rapor (no_daftar, kkm_mtk, kkm_kimia, kkm_fisika, "
			+ "kkm_biologi, kkm_sejarah, kkm_geografi, kkm_ekonomi, "
			+ "kkm_bindo, kkm_bing, mtk, kimia, fisika, biologi, sejarah, geografi, "
			+ "ekonomi, bindo, bing) VALUES"
			+ "(#{no_daftar}, #{kkm_mtk}, #{kkm_kimia}, #{kkm_fisika}, "
			+ "#{kkm_biologi}, #{kkm_sejarah}, #{kkm_geografi}, #{kkm_ekonomi}, "
			+ "#{kkm_bindo}, #{kkm_bing}, #{mtk}, #{kimia}, #{fisika}, #{biologi}, #{sejarah}, #{geografi}, "
			+ "#{ekonomi}, #{bindo}, #{bing})")
	void addNilai(NilaiModel nilai);
	
	@Select("select * from lembaga_pendidikan_terakhir")
	@Results(value = {
			@Result(property="nama_lembaga", column="nama_lembaga"),
			@Result(property="nama_provinsi", column="nama_provinsi"),
			@Result(property="nama_kota", column="nama_kota")})
	List<LPTerdahuluModel> selectAllLPT();
}
