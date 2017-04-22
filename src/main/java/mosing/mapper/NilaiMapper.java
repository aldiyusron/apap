package mosing.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import mosing.model.NilaiModel;

@Mapper
public interface NilaiMapper {
	@Insert("INSERT INTO nilai_rapor (no_daftar, kkm_mtk, kkm_kimia, kkm_fisika, "
			+ "kkm_biologi, kkm_sejarah, kkm_geografi, kkm_ekonomi, "
			+ "kkm_bindo, kkm_bing, mtk, kimia, fisika, biologi, sejarah, geografi, " + "ekonomi, bindo, bing) VALUES"
			+ "(#{no_daftar}, #{kkm_mtk}, #{kkm_kimia}, #{kkm_fisika}, "
			+ "#{kkm_biologi}, #{kkm_sejarah}, #{kkm_geografi}, #{kkm_ekonomi}, "
			+ "#{kkm_bindo}, #{kkm_bing}, #{mtk}, #{kimia}, #{fisika}, #{biologi}, #{sejarah}, #{geografi}, "
			+ "#{ekonomi}, #{bindo}, #{bing})")
	void addNilai(NilaiModel nilai);
}
