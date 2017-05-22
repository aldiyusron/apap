package mosing.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import mosing.model.NilaiModel;
import mosing.model.NilaiUjianModel;
import mosing.model.PendaftarModel;

@Mapper
public interface NilaiMapper {
	@Insert("INSERT INTO NILAI_RAPOR (no_daftar, kkm_mtk, kkm_kimia, kkm_fisika, "
			+ "kkm_biologi, kkm_sejarah, kkm_geografi, kkm_ekonomi, kkm_sosiologi, "
			+ "kkm_bindo, kkm_bing, mtk, kimia, fisika, biologi, sejarah, geografi, "
			+ "ekonomi, sosiologi, bindo, bing, semester) VALUES" + "(#{no_daftar}, #{kkm_mtk}, #{kkm_kimia}, #{kkm_fisika}, "
			+ "#{kkm_biologi}, #{kkm_sejarah}, #{kkm_geografi}, #{kkm_ekonomi}, #{kkm_sosiologi}, "
			+ "#{kkm_bindo}, #{kkm_bing}, #{mtk}, #{kimia}, #{fisika}, #{biologi}, #{sejarah}, #{geografi}, "
			+ "#{ekonomi}, #{sosiologi}, #{bindo}, #{bing}, #{semester})")
	void addNilai(NilaiModel nilai);

	@Select("SELECT * FROM NILAI_RAPOR WHERE no_daftar=#{no_daftar}")
	List<NilaiModel> selectNilai(@Param("no_daftar") int no_daftar);

	@Update("UPDATE NILAI_RAPOR SET kkm_mtk = #{kkm_mtk}, kkm_fisika = #{kkm_fisika}, kkm_biologi = #{kkm_biologi}, "
			+ "kkm_sejarah = #{kkm_sejarah}, kkm_geografi = #{kkm_geografi}, kkm_ekonomi = #{kkm_ekonomi}, kkm_sosiologi = #{kkm_sosiologi}, kkm_bindo = #{kkm_bindo}, "
			+ "kkm_bing = #{kkm_bing}, mtk = #{mtk}, kimia = #{kimia}, fisika = #{fisika}, biologi = #{biologi}, sejarah = #{sejarah}, geografi = #{geografi},"
			+ " ekonomi=#{ekonomi}, sosiologi=#{sosiologi}, bindo = #{bindo}, bing = #{bing} WHERE semester = #{semester} AND no_daftar=#{no_daftar}")
	void updateNilai(NilaiModel nilai);

	@Select("SELECT * FROM NILAI_UJIAN WHERE no_daftar = #{no_daftar}")
	NilaiUjianModel selectNilaiUjian(@Param("no_daftar") int no_daftar);
}
